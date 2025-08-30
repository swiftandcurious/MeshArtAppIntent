//
//  DisablePopGesture.swift
//  MeshArtAppIntent
//
//  Created by swiftandcurious on 8/23/25.
//

import SwiftUI

/// A helper view that disables the interactive pop gesture for its containing view controller.
struct DisablePopGesture: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        // Disable the interactive pop gesture once the view appears.
        DispatchQueue.main.async {
            controller.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}

extension View {
    /// A view modifier that disables the interactive pop (swipe-back) gesture.
    func disableInteractivePopGesture() -> some View {
        self.background(DisablePopGesture())
    }
}
