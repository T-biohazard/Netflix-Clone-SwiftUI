//
//  TransparentBlurView.swift
//  NetflixClone
//
//  Created by tashin on 2/23/25.
//


import SwiftUI

struct TransparentBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurView = UIVisualEffectView(effect: nil) // Start with no effect
        blurView.backgroundColor = UIColor.clear // Ensure transparency
        return blurView
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        UIView.animate(withDuration: 0.2) { // Smooth transition
            uiView.effect = UIBlurEffect(style: .systemUltraThinMaterial)
        }
    }
}
