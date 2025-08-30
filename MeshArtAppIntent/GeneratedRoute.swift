//
//  GeneratedRoute.swift
//  MeshArtAppIntent
//
//  Created by swiftandcurious on 8/30/25.
//

import SwiftUI

// Make the route Identifiable so we can use item-based navigation.
struct GeneratedRoute: Identifiable, Hashable {
    let id = UUID()
    let rows: Int
    let cols: Int
    let palette: Palette

    var title: String {
        "GeneratedMeshView (\(rows)×\(cols) \(palette.rawValue.capitalized))"
    }
}
