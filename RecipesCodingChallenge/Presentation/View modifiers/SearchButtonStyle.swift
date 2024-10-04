//
//  SearchButtonStyle.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 3/10/24.
//

import Foundation
import SwiftUI

public struct SearchButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.ui.primary)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        
    }
}
