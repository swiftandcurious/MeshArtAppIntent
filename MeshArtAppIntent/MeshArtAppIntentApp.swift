//
//  MeshArtAppIntentApp.swift
//  MeshArtAppIntent
//
//  Created by swiftandcurious on 8/23/25.
//

import SwiftUI
import AppIntents

@main
struct MeshArtAppIntentApp: App {
    @StateObject private var meshController: MeshController

    init() {
        // 1) Create the controller first
        let controller = MeshController()
        // 2) Initialize the StateObject via its backing storage
        _meshController = StateObject(wrappedValue: controller)
        // 3) Register THIS instance for @Dependency
        AppDependencyManager.shared.add(dependency: controller)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(meshController)
        }
    }
}
