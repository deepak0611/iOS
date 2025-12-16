import SwiftUI

// MARK: - Circle Shape

/// A custom SwiftUI Shape that draws a filled and stroked circle.
struct CircleShape: Shape {
    var center: CGPoint
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // The path is defined relative to the view's local coordinate space.
        // The adjusted center shifts the origin to the center of the drawing area.
        let adjustedCenter = CGPoint(x: rect.midX + center.x, y: rect.midY - center.y)
        
        path.addArc(
            center: adjustedCenter,
            radius: radius,
            startAngle: .degrees(0),
            endAngle: .degrees(360),
            clockwise: true
        )
        return path
    }
}

// MARK: - Coordinate Plane Shape

/// A custom SwiftUI Shape that draws the X and Y axes of a 2D coordinate plane.
struct CoordinatePlane: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let centerX = rect.midX
        let centerY = rect.midY
        
        // Draw X-axis
        path.move(to: CGPoint(x: rect.minX, y: centerY))
        path.addLine(to: CGPoint(x: rect.maxX, y: centerY))
        
        // Draw Y-axis
        path.move(to: CGPoint(x: centerX, y: rect.minY))
        path.addLine(to: CGPoint(x: centerX, y: rect.maxY))
        
        return path
    }
}

// MARK: - Main View

/// A SwiftUI view that visualizes a 2D coordinate plane and a circle.
struct DrawingView: View {
    
    /// The circles' data: an array of [x-coordinate, y-coordinate, radius].
    /// This is defined in the parent view.
    var circlesData: [[CGFloat]]
    
    @State private var scale: CGFloat = 1.0
    @State private var currentScale: CGFloat = 1.0
    
    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: true) {
            ZStack {
                // Layer 1: The coordinate plane axes
                CoordinatePlane()
                    .stroke(Color.black, lineWidth: 2 / (scale * currentScale)) // Adjust line width with scale for consistent appearance
                
                // Layer 2: The circles
                ForEach(circlesData.indices, id: \.self) { index in
                    let circle = circlesData[index]
                    if circle.count == 3 {
                        CircleShape(center: CGPoint(x: circle[0], y: circle[1]), radius: circle[2])
                            .fill(Color.blue.opacity(0.6))
                            .stroke(Color.blue, lineWidth: 3 / (scale * currentScale)) // Adjust line width
                    }
                }
            }
            .frame(width: 1000, height: 1000) // Set a large, fixed frame to enable scrolling
            .scaleEffect(scale * currentScale)
            .gesture(MagnificationGesture()
                .onChanged { value in
                    self.currentScale = value
                }
                .onEnded { value in
                    self.scale *= value
                    self.currentScale = 1.0
                }
            )
        }
    }
}

// MARK: - Preview

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView(circlesData: [[-100, -100, 50], [50, 50, 40], [200, -200, 60]])
            .previewDisplayName("2D Coordinate Plane with Multiple Circles")
            .padding()
    }
}

