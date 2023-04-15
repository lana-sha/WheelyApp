//
//  SpinView.swift
//  WheelyApp
//
//  Created by Lana Shatonova on 14/04/23.
//

import SwiftUI

struct SpinView: View {

    let options: [String]

    @State private var animationDegrees: Double = 0

    var body: some View {
        VStack {
            // Header
            Text("Let the wheel decide your fate!")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.darkText)
                .multilineTextAlignment(.center)
                .padding(.largePadding)
                .bubble()

            Spacer()

            // Wheel
            WheelView(options: options)
                .rotationEffect(.degrees(animationDegrees))
                .animation(
                    .spring(response: 1.2, dampingFraction: 1.5, blendDuration: 1.5),
                    value: animationDegrees)
                .overlay(alignment: .trailing) {
                    ZStack {
                        Triangle()
                            .fill(Color.bubbleBackground)
                        Triangle()
                            .stroke(Color.darkText, lineWidth: 1)
                    }
                    .frame(width: 25, height: 25)
                    .offset(CGSize(width: 0, height: 10))
                    .rotationEffect(.degrees(-90))
                }
                .padding(.horizontal, .extraLargePadding)

            Spacer()

            // Action button
            Button("Spin") {
                // Do not allow the wheel to stop exactly on an angle in between options
                let angleDegrees = 360 / Double(options.count)
                animationDegrees += .random(in: 1000...2000)
                if animationDegrees.truncatingRemainder(dividingBy: angleDegrees) == 0 {
                    animationDegrees += 2
                }
            }
            .buttonStyle(ActionButtonStyle())
            .disabled(options.isEmpty)
            .padding(.horizontal, .mediumPadding)
        }
        .padding(.vertical, .largePadding)
        .background { Color.screenBackground.ignoresSafeArea() }
        .navigationTitle("Wheel of Fortune")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SpinView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SpinView(options: ["Lana", "Jane", "Mary", "Jess", "Lisa"])
        }
    }
}
