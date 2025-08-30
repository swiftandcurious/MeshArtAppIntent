//
//  Palette+UI.swift
//  MeshArtAppIntent
//
//  Created by swiftandcurious on 8/23/25.
//

import SwiftUI

@MainActor
extension Palette {
    var bandColors: (top: Color, mid: Color, bottom: Color) {
        switch self {
        case .sunset:
            return (.orange, .pink, .purple)
        case .ocean:
            return (.cyan, .blue, .indigo)
        case .forest:
            return (.green, .mint, .teal)
        case .desert:
            return (.yellow, .orange, .brown)
        case .aurora:
            return (.purple, .mint, .blue)
        case .lava:
            return (.red, .orange, .black)
        case .galaxy:
            return (.indigo, .purple, .black)
        case .pastel:
            return (.pink.opacity(0.7), .mint.opacity(0.7), .yellow.opacity(0.7))
        case .neon:
            return (.green, .pink, .cyan)
        }
    }
}
