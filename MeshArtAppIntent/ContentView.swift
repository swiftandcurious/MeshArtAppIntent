//
//  ContentView.swift
//  MeshArtAppIntent
//
//  Created by swiftandcurious on 8/23/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject private var meshController: MeshController

    // Label state for the list row (what the user sees)
    @State private var generatedLabel = GeneratedRoute(rows: 4, cols: 6, palette: .sunset)
    // Route used to *navigate* (nil means not pushed)
    @State private var navRoute: GeneratedRoute?

    var body: some View {
        NavigationStack {
            List {
                NavigationLink("StaticMeshGradientView", destination: StaticMeshGradientView())
                NavigationLink("PrideView", destination: PrideView())
                NavigationLink("DraggableMeshView", destination: DraggableMeshView())

                // Use a Button so we can push programmatically every time.
                Button {
                    // Always push: assign a fresh route (new UUID) from the current label.
                    navRoute = GeneratedRoute(
                        rows: generatedLabel.rows,
                        cols: generatedLabel.cols,
                        palette: generatedLabel.palette
                    )
                } label: {
                    HStack {
                        Text(generatedLabel.title)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                    }
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("MeshArt")
            // Item-based destination is rock-solid and doesn’t need NavigationPath.
            .navigationDestination(item: $navRoute) { route in
                GeneratedMeshView(rows: route.rows, cols: route.cols, palette: route.palette)
            }
        }
        // Single unified handler: initial pending (if any) + future updates from the intent.
        .onReceive(
            Publishers.Merge(
                Just(meshController.pending).compactMap { $0 },
                meshController.$pending.dropFirst().compactMap { $0 }
            )
        ) { req in
            // Update the row label so the menu reflects latest params
            generatedLabel = GeneratedRoute(
                rows: max(2, req.rows),
                cols: max(2, req.cols),
                palette: req.palette
            )
            // And push immediately (fresh id ensures a new navigation even if params match)
            navRoute = GeneratedRoute(
                rows: generatedLabel.rows,
                cols: generatedLabel.cols,
                palette: generatedLabel.palette
            )
            // Clear the pending request so we don't re-trigger.
            meshController.pending = nil
        }
    }
}


#Preview {
    ContentView()
}
