//
//  GenerateMeshIntent.swift
//  MeshArtAppIntent
//
//  Created by swiftandcurious on 8/23/25.
//

import AppIntents

struct GenerateMeshIntent: AppIntent {
    static var title: LocalizedStringResource = "Generate Mesh"
    static var openAppWhenRun: Bool = true

    @Parameter(title: "Rows")    var rows: Int
    @Parameter(title: "Columns") var cols: Int
    @Parameter(title: "Palette") var palette: Palette

    @Dependency var meshController: MeshController

    static var parameterSummary: some ParameterSummary {
        Summary("Generate a \(\.$rows) by \(\.$cols) mesh with \(\.$palette) colors")
    }

    func perform() async throws -> some IntentResult & ProvidesDialog {
        // Actually hop to the main actor (this is async) so 'await' is meaningful
        await MainActor.run {
            meshController.generate(rows: rows, cols: cols, palette: palette)
        }
        return .result(dialog: "Opening MeshArt…")
    }
}
