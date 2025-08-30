//
//  Palettes.swift
//  MeshArtAppIntent
//
//  Created by swiftandcurious on 8/23/25.
//

import AppIntents

enum Palette: String, AppEnum, Sendable {
    case sunset, ocean, forest, desert, aurora, lava, galaxy, pastel, neon

    nonisolated static var typeDisplayRepresentation: TypeDisplayRepresentation {
        TypeDisplayRepresentation(name: "Palette")
    }

    nonisolated static var caseDisplayRepresentations: [Palette: DisplayRepresentation] {
        [
            .sunset: .init(title: "Sunset"),
            .ocean:  .init(title: "Ocean"),
            .forest: .init(title: "Forest"),
            .desert: .init(title: "Desert"),
            .aurora: .init(title: "Aurora"),
            .lava:   .init(title: "Lava"),
            .galaxy: .init(title: "Galaxy"),
            .pastel: .init(title: "Pastel"),
            .neon:   .init(title: "Neon"),
        ]
    }
}
