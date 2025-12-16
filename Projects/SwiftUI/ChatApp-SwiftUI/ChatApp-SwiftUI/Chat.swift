//
//  Chat.swift
//  ChatApp-SwiftUI
//
//  Created by Deepak Kumar1 on 26/08/25.
//

// Swift WebSocket Chat App Example
// - SwiftUI single-file demo app
// - Uses URLSessionWebSocketTask
// - Includes reconnect w/ exponential backoff, heartbeats, and JSON encoding
//
// Tested targeting iOS 15+

import SwiftUI
import Combine

// MARK: - Models

struct ChatMessage: Identifiable, Codable, Equatable {
    let id: UUID
    let text: String
    let sender: String
    let timestamp: Date

    init(id: UUID = UUID(), text: String, sender: String, timestamp: Date = Date()) {
        self.id = id
        self.text = text
        self.sender = sender
        self.timestamp = timestamp
    }
}

// MARK: - Connection State

enum WebSocketState: Equatable {
    case disconnected
    case connecting
    case connected
    case error(String)
}

// MARK: - WebSocket Client

final class WebSocketClient: ObservableObject {
    @Published private(set) var state: WebSocketState = .disconnected

    private var url: URL
    private var session: URLSession!
    private var task: URLSessionWebSocketTask?

    private var pingTimer: Timer?
    private let pingInterval: TimeInterval = 15

    private var reconnectWorkItem: DispatchWorkItem?
    private var reconnectAttempt: Int = 0
    private let maxReconnectDelay: TimeInterval = 30

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(url: URL) {
        self.url = url
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        self.session = URLSession(configuration: config)
        decoder.dateDecodingStrategy = .iso8601
        encoder.dateEncodingStrategy = .iso8601
    }

    func connect() {
        guard task == nil else { return }
        state = .connecting
        var request = URLRequest(url: url)
        // Example header if you need auth tokens:
        // request.addValue("Bearer <token>", forHTTPHeaderField: "Authorization")
        let task = session.webSocketTask(with: request)
        self.task = task
        task.resume()
        listen()
        startPinging()
        state = .connected
        reconnectAttempt = 0
    }

    func disconnect() {
        stopPinging()
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
        state = .disconnected
    }

    func send(_ message: ChatMessage) {
        do {
            let data = try encoder.encode(message)
            let string = String(data: data, encoding: .utf8) ?? "{}"
            task?.send(.string(string)) { [weak self] error in
                if let error = error { self?.handleError(error) }
            }
        } catch {
            handleError(error)
        }
    }

    private func startPinging() {
        stopPinging()
        pingTimer = Timer.scheduledTimer(withTimeInterval: pingInterval, repeats: true) { [weak self] _ in
            self?.task?.sendPing { error in
                if let error = error { self?.handleError(error) }
            }
        }
    }

    private func stopPinging() {
        pingTimer?.invalidate()
        pingTimer = nil
    }

    private func scheduleReconnect() {
        guard task != nil else { return }
        // Prevent overlapping reconnects
        reconnectWorkItem?.cancel()

        let delay = min(pow(2.0, Double(reconnectAttempt)), maxReconnectDelay)
        reconnectAttempt += 1

        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.disconnect()
            self.connect()
        }
        reconnectWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
    }

    private func listen() {
        task?.receive { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.handleError(error)
            case .success(let message):
                switch message {
                case .string(let text):
                    self.handleIncoming(text: text)
                case .data(let data):
                    if let text = String(data: data, encoding: .utf8) {
                        self.handleIncoming(text: text)
                    }
                @unknown default:
                    break
                }
                // Keep listening
                self.listen()
            }
        }
    }

    private func handleIncoming(text: String) {
        // Broadcast using NotificationCenter to decouple view model
        NotificationCenter.default.post(name: .websocketIncomingString, object: text)
    }

    private func handleError(_ error: Error) {
        state = .error(error.localizedDescription)
        scheduleReconnect()
    }
}

extension Notification.Name {
    static let websocketIncomingString = Notification.Name("websocketIncomingString")
}

// MARK: - ViewModel

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var input: String = ""
    @Published var connectionState: WebSocketState = .disconnected

    private var client: WebSocketClient
    private var cancellables = Set<AnyCancellable>()
    private let decoder = JSONDecoder()

    init(url: URL, me: String) {
        self.client = WebSocketClient(url: url)
        self.me = me
        decoder.dateDecodingStrategy = .iso8601

        // Mirror client's state
        client.$state
            .receive(on: RunLoop.main)
            .assign(to: &$connectionState)

        // Observe incoming messages
        NotificationCenter.default.publisher(for: .websocketIncomingString)
            .compactMap { $0.object as? String }
            .sink { [weak self] text in
                self?.handleIncomingText(text)
            }
            .store(in: &cancellables)
    }

    let me: String

    func connect() { client.connect() }
    func disconnect() { client.disconnect() }

    func send() {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let message = ChatMessage(text: trimmed, sender: me)
        client.send(message)
        DispatchQueue.main.async {
            self.messages.append(message) // Optimistic update
        }
        input = ""
    }

    private func handleIncomingText(_ text: String) {
        // Try to decode as ChatMessage first; if it fails, wrap raw text
        if let data = text.data(using: .utf8),
           let msg = try? decoder.decode(ChatMessage.self, from: data) {
            DispatchQueue.main.async {
                self.messages.append(msg)
            }
        } else {
            DispatchQueue.main.async {
                self.messages.append(ChatMessage(text: text, sender: "server"))
            }
        }
    }
}

// MARK: - Views

struct ChatView: View {
    @StateObject private var vm: ChatViewModel

    init(serverURL: URL, me: String = "me") {
        _vm = StateObject(wrappedValue: ChatViewModel(url: serverURL, me: me))
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(vm.messages) { msg in
                            MessageRow(message: msg, isMe: msg.sender == vm.me)
                                .id(msg.id)
                        }
                    }
                    .padding(12)
                }
                .onChange(of: vm.messages.count) { _ in
                    if let last = vm.messages.last?.id {
                        withAnimation { proxy.scrollTo(last, anchor: .bottom) }
                    }
                }
            }
            Divider()
            inputBar
        }
        .onAppear { vm.connect() }
        .onDisappear { vm.disconnect() }
    }

    private var header: some View {
        HStack {
            Text("WebSocket Chat")
                .font(.headline)
            Spacer()
            Circle()
                .fill(colorForState(vm.connectionState))
                .frame(width: 10, height: 10)
            Text(labelForState(vm.connectionState))
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }

    private var inputBar: some View {
        HStack(spacing: 8) {
            TextField("Type a message", text: $vm.input)
                .textFieldStyle(.roundedBorder)
                .onSubmit(vm.send)
            Button(action: vm.send) {
                Image(systemName: "paperplane.fill")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(12)
        .background(.ultraThinMaterial)
    }

    private func colorForState(_ state: WebSocketState) -> Color {
        switch state {
        case .disconnected: return .gray
        case .connecting: return .yellow
        case .connected: return .green
        case .error: return .red
        }
    }

    private func labelForState(_ state: WebSocketState) -> String {
        switch state {
        case .disconnected: return "Disconnected"
        case .connecting: return "Connecting"
        case .connected: return "Connected"
        case .error(let msg): return "Error: \(msg)"
        }
    }
}

struct MessageRow: View {
    let message: ChatMessage
    let isMe: Bool

    var body: some View {
        HStack {
            if isMe { Spacer(minLength: 40) }
            VStack(alignment: .leading, spacing: 4) {
                Text(message.text)
                    .padding(10)
                    .background(isMe ? Color.blue.opacity(0.15) : Color.gray.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                Text("\(message.sender) • \(format(date: message.timestamp))")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            if !isMe { Spacer(minLength: 40) }
        }
        .transition(.opacity.combined(with: .move(edge: isMe ? .trailing : .leading)))
    }

    private func format(date: Date) -> String {
        let f = DateFormatter()
        f.timeStyle = .short
        f.dateStyle = .none
        return f.string(from: date)
    }
}

//// MARK: - App Entry (for one-file demo)
//
//@main
//struct WebSocketChatDemoApp: App {
//    // For quick testing you can use a public echo server which echoes back strings
//    // NOTE: Replace this with your own WS endpoint, e.g., wss://yourhost/chat
//    private let demoURL = URL(string: "wss://echo.websocket.events")!
//
//    var body: some Scene {
//        WindowGroup {
//            ChatView(serverURL: demoURL, me: "alice")
//        }
//    }
//}
