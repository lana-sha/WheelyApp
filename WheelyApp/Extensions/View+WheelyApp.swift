//
//  View+WheelyApp.swift
//  WheelyApp
//
//  Created by Lana Shatonova on 13/04/23.
//

import SwiftUI

extension View {
    func dropShadow() -> some View {
        self.shadow(color: .secondaryPurple.opacity(0.3), radius: 4, x: 0, y: 2)
    }

    func bubble() -> some View {
        self.background {
            RoundedRectangle(cornerRadius: .cornerRadius)
                .fill(Color.bubbleBackground)
                .dropShadow()
        }
    }
}
