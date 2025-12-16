//
//  ScreenView.swift
//  zomatoR1-swiftui
//
//  Created by Deepak Kumar1 on 07/08/25.
//
import SwiftUI

struct ScreenView: View {
    let width: CGFloat
    let height: CGFloat
    var n: Int
    let colors = [Color.red, Color.blue, Color.green, Color.gray]
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                getEmptyView(width: width / 2.0, height: height / 2.0, nValue: n-1)
                getView()
                    .frame(width:  width / 2.0, height: height / 2.0)
            }
            HStack(spacing: 0) {
                getView()
                    .frame(width:  width / 2.0, height: height / 2.0)
                getEmptyView(width: width / 2.0, height: height / 2.0, nValue: n-1)
            }
        }
    }
    func getEmptyView(width: CGFloat, height: CGFloat, nValue: Int) -> some View {
        ZStack {
            Group {
                Image(systemName: "plus")
                    .frame(width: width, height: height)
                    .background(colors[nValue])
                if(nValue>0) {
                    ScreenView(width: width, height: height, n: nValue)
                }
            }
        }
    }
    
    func getView() -> some View {
        ZStack {
            Color.clear
        }
    }
    
}

#Preview {
    ScreenView(width: 500, height: 500, n: 1)
}
