//
//  StaticMeshGradientView.swift
//  MeshArtAppIntent
//
//  Created by swiftandcurious on 8/23/25.
//

import SwiftUI

struct StaticMeshGradientView: View {
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                [0.0, 0.5], [0.9, 0.3], [1.0, 0.5],
                [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
            ],
            colors: [
                .black,.black,.black,
                .blue, .blue, .blue,
                .green, .green, .green
            ]
        )
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    StaticMeshGradientView()
}
