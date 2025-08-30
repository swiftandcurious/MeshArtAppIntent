//
//  PrideView.swift
//  MeshArtAppIntent
//
//  Created by swiftandcurious on 8/23/25.
//

import SwiftUI

struct PrideView: View {
    var body: some View {
        VStack {
            Text("Pride")
                .font(.system(size: 144, weight: .bold))
                .stripes(.red, .orange, .yellow, .green, .blue, .purple)
            
            Circle()
                .stripes(.red, .orange, .yellow, .green, .blue, .purple)
                .padding()
        }
    }
}

struct StripesModifier: ViewModifier {
    let colors: [Color]
    
    func body(content: Content) -> some View {
        let rows = colors.count
        
        let points: [SIMD2<Float>] = {
            if rows <= 1 {
                return [SIMD2<Float>(0, 0), SIMD2<Float>(1, 0)]
            } else {
                return (0..<rows).flatMap { i -> [SIMD2<Float>] in
                    let y = Float(i) / Float(rows - 1)
                    return [SIMD2<Float>(0, y), SIMD2<Float>(1, y)]
                }
            }
        }()
        
        let duplicatedColors = colors.flatMap { [ $0, $0 ] }
        
        return content
            .foregroundStyle(
                MeshGradient(
                    width: 2,
                    height: rows,
                    points: points,
                    colors: duplicatedColors
                )
            )
    }
}

extension View {
    func stripes(_ colors: Color...) -> some View {
        self.modifier(StripesModifier(colors: colors))
    }
}

#Preview {
    PrideView()
}
