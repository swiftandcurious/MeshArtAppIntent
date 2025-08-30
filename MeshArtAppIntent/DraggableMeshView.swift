//
//  DraggableMeshView.swift
//  MeshArtAppIntent
//
//  Created by swiftandcurious on 8/23/25.
//

import SwiftUI

struct DraggableMeshView: View {
    
    private let framePoints: [CGPoint] = [
        CGPoint(x: 0.0, y: 0.0), CGPoint(x: 0.5, y: 0.0), CGPoint(x: 1.0, y: 0.0),
        CGPoint(x: 0.0, y: 0.5), CGPoint(x: 0.5, y: 0.5), CGPoint(x: 1.0, y: 0.5),
        CGPoint(x: 0.0, y: 1.0), CGPoint(x: 0.5, y: 1.0), CGPoint(x: 1.0, y: 1.0)
    ]
    
    @State private var initialDragPoints: [CGPoint] = [
        CGPoint(x: 0.01, y: 0.01), CGPoint(x: 0.5, y: 0.01), CGPoint(x: 0.99, y: 0.01),
        CGPoint(x: 0.01, y: 0.5), CGPoint(x: 0.5, y: 0.5), CGPoint(x: 0.99, y: 0.5),
        CGPoint(x: 0.01, y: 0.99), CGPoint(x: 0.5, y: 0.99), CGPoint(x: 0.99, y: 0.99)
    ]
    
    @State private var dragPoints: [CGPoint] = [
        CGPoint(x: 0.01, y: 0.01), CGPoint(x: 0.5, y: 0.01), CGPoint(x: 0.99, y: 0.01),
        CGPoint(x: 0.01, y: 0.5), CGPoint(x: 0.5, y: 0.5), CGPoint(x: 0.99, y: 0.5),
        CGPoint(x: 0.01, y: 0.99), CGPoint(x: 0.5, y: 0.99), CGPoint(x: 0.99, y: 0.99)
    ]
    
    
    @State private var topColor: Color = .black
    @State private var middleColor: Color = .blue
    @State private var bottomColor: Color = .green
    
    @State private var showColorPickers: Bool = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    
                    MeshGradient(
                        width: 3,
                        height: 3,
                        points: framePoints.map { [Float($0.x), Float($0.y)] },
                        colors: [
                            topColor, topColor, topColor,
                            middleColor, middleColor, middleColor,
                            bottomColor, bottomColor, bottomColor
                        ]
                    )
                    .ignoresSafeArea(edges: .all)
                    
                    MeshGradient(
                        width: 3,
                        height: 3,
                        points: dragPoints.map { [Float($0.x), Float($0.y)] },
                        colors: [
                            topColor, topColor, topColor,
                            middleColor, middleColor, middleColor,
                            bottomColor, bottomColor, bottomColor
                        ]
                    )
                    .ignoresSafeArea(edges: .all)
                    
                    // Overlay draggable points.
                    ForEach(dragPoints.indices, id: \.self) { index in
                        Circle()
                            .fill(Color.white)
                            .frame(width: 10, height: 10)
                            .padding(5)
                            .shadow(color: .black, radius: 0.5, x: 0.5, y: 0.5)
                            .position(
                                x: dragPoints[index].x * geometry.size.width,
                                y: dragPoints[index].y * geometry.size.height
                            )
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        let newX = value.location.x / geometry.size.width
                                        let newY = value.location.y / geometry.size.height
                                        dragPoints[index] = CGPoint(
                                            x: min(max(newX, 0.01), 0.99),
                                            y: min(max(newY, 0.01), 0.99)
                                        )
                                    }
                            )
                    }
                }
            }
            .overlay(
                VStack {
                    ColorPicker("", selection: $topColor)
                        .labelsHidden()
                    Spacer()
                    ColorPicker("", selection: $middleColor)
                        .labelsHidden()
                    Spacer()
                    ColorPicker("", selection: $bottomColor)
                        .labelsHidden()
                }
                    .padding()
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea(edges: .bottom)
                    .offset(x: showColorPickers ? 0 : 150)
                    .animation(.easeInOut, value: showColorPickers)
                , alignment: .trailing
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                showColorPickers.toggle()
                            }
                        }, label: {
                            Image(systemName: showColorPickers ? "xmark.circle" : "paintpalette")
                                .symbolRenderingMode(showColorPickers ? .monochrome : .multicolor)
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(8)
                                .shadow(color: .black, radius: 1, x: 1, y: 3)
                                .foregroundColor(.white)
                        })
                        
                        Button(action: {
                            dragPoints = initialDragPoints
                        }, label: {
                            Image(systemName: "arrow.counterclockwise.circle")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(8)
                                .shadow(color: .black, radius: 1, x: 1, y: 3)
                                .foregroundColor(.white)
                        })
                    }
                }
            }
            .disableInteractivePopGesture()
        }
    }
}

#Preview {
    DraggableMeshView()
}
