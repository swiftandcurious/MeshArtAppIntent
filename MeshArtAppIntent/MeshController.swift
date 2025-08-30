//
//  MeshController.swift
//  MeshArtAppIntent
//
//  Created by swiftandcurious on 8/24/25.
//

import Foundation
import Combine


final class MeshController: ObservableObject {
    @Published var pending: (rows: Int, cols: Int, palette: Palette)?

    @MainActor
    func generate(rows: Int, cols: Int, palette: Palette) {
        pending = (rows, cols, palette)
    }
}
