//
//  GeneratedMeshView.swift
//  MeshArtAppIntent
//
//  Created by swiftandcurious on 8/23/25.
//

import SwiftUI

struct GeneratedMeshView: View {
    let rows: Int
    let cols: Int
    let palette: Palette

    // Drag state (normalized [0,1] coordinates)
    @State private var dragPoints: [CGPoint] = []
    private let margin: CGFloat = 0.01   // tiny inset to avoid edge artifacts

    // Fixed frame points at exact grid positions (0...1)
    private var framePoints: [CGPoint] {
        let r = max(2, rows), c = max(2, cols)
        return (0..<r).flatMap { row in
            (0..<c).map { col in
                CGPoint(
                    x: CGFloat(col) / CGFloat(max(1, c - 1)),
                    y: CGFloat(row) / CGFloat(max(1, r - 1))
                )
            }
        }
    }

    // Initial drag points = slightly inset version of the grid
    private var initialDragPoints: [CGPoint] {
        framePoints.map { p in
            CGPoint(
                x: p.x * (1 - 2 * margin) + margin,
                y: p.y * (1 - 2 * margin) + margin
            )
        }
    }

    // Colors as 3 horizontal bands (top/mid/bottom)
    private var colors: [Color] {
        let (top, mid, bottom) = palette.bandColors
        let r = max(2, rows), c = max(2, cols)
        let band1 = r / 3
        let band2 = 2 * r / 3
        return (0..<r).flatMap { row in
            let rowColor: Color = (row < band1) ? top : (row < band2) ? mid : bottom
            return Array(repeating: rowColor, count: c)
        }
    }

    // Mapping helpers
    private func cgToSimd(_ points: [CGPoint]) -> [SIMD2<Float>] {
        points.map { SIMD2(Float($0.x), Float($0.y)) }
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Base mesh with fixed frame points (nice “lattice” blend behind)
                MeshGradient(
                    width: max(2, cols),
                    height: max(2, rows),
                    points: cgToSimd(framePoints),
                    colors: colors
                )
                .ignoresSafeArea()

                // Foreground mesh driven by draggable points
                MeshGradient(
                    width: max(2, cols),
                    height: max(2, rows),
                    points: cgToSimd(dragPoints.isEmpty ? initialDragPoints : dragPoints),
                    colors: colors
                )
                .ignoresSafeArea()

                // Draggable handles
                ForEach((dragPoints.isEmpty ? initialDragPoints : dragPoints).indices, id: \.self) { idx in
                    let pts = dragPoints.isEmpty ? initialDragPoints : dragPoints
                    Circle()
                        .fill(.white)
                        .frame(width: 10, height: 10)
                        .padding(5)
                        .shadow(color: .black.opacity(0.6), radius: 0.5, x: 0.5, y: 0.5)
                        .position(
                            x: pts[idx].x * geo.size.width,
                            y: pts[idx].y * geo.size.height
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    // Lazily initialize dragPoints on first drag
                                    if dragPoints.isEmpty {
                                        dragPoints = initialDragPoints
                                    }
                                    let nx = value.location.x / geo.size.width
                                    let ny = value.location.y / geo.size.height
                                    dragPoints[idx] = CGPoint(
                                        x: min(max(nx, margin), 1 - margin),
                                        y: min(max(ny, margin), 1 - margin)
                                    )
                                }
                        )
                }
            }
        }
        .overlay(alignment: .topLeading) {
            HStack(spacing: 8) {
                // Tiny swatches to hint the palette bands
                let (t, m, b) = palette.bandColors
                RoundedRectangle(cornerRadius: 2).fill(t).frame(width: 14, height: 8)
                RoundedRectangle(cornerRadius: 2).fill(m).frame(width: 14, height: 8)
                RoundedRectangle(cornerRadius: 2).fill(b).frame(width: 14, height: 8)

                Text("\(rows)×\(cols) • \(palette.rawValue.capitalized)")
                    .font(.headline)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.ultraThinMaterial, in: Capsule())
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Reset back to the initial inset grid
                    dragPoints = initialDragPoints
                } label: {
                    Image(systemName: "arrow.counterclockwise.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(6)
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.7), radius: 1, x: 1, y: 3)
                }
            }
        }
    }
}

#Preview {
    GeneratedMeshView(rows: 4, cols: 6, palette: .sunset)
}

#Preview {
    GeneratedMeshView(rows: 3, cols: 3, palette: .sunset)
}

