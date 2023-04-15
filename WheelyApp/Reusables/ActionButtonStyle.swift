//
//  ActionButtonStyle.swift
//  WheelyApp
//
//  Created by Lana Shatonova on 13/04/23.
//

import SwiftUI

struct ActionButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body)
            .fontWeight(.medium)
            .foregroundColor(.lightText)
            .frame(maxWidth: .infinity)
            .padding(.mediumPadding)
            .background {
                RoundedRectangle(cornerRadius: .cornerRadius)
                    .fill(backgroundColor(isPressed: configuration.isPressed))
                    .dropShadow()
            }
            .animation(.default, value: configuration.isPressed)
            .animation(.default, value: isEnabled)
    }

    private func backgroundColor(isPressed: Bool) -> Color {
        if isEnabled {
            return isPressed ? .secondaryPurple : .primaryPurple
        } else {
            return .tertiaryPurple
        }
    }
}

struct ActionButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("Action") { }

            Button("Action") { }
                .disabled(true)
        }
        .padding()
        .buttonStyle(ActionButtonStyle())
    }
}
