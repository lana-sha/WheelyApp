//
//  WheelView.swift
//  WheelyApp
//
//  Created by Lana Shatonova on 14/04/23.
//

import SwiftUI

struct WheelView: View {

    let options: [String]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Wheel
                if !options.isEmpty {
                    let angleDegrees = 360 / Double(options.count)
                    ForEach(options.indices, id: \.self) { index in
                        WheelSectorView(
                            text: options[index],
                            startAngle: .degrees(Double(index) * angleDegrees),
                            endAngle: .degrees(Double(index + 1) * angleDegrees))
                    }
                } else {
                    WheelSectorView(text: "", startAngle: .zero, endAngle: .degrees(360))
                }

                // Circle in the middle
                let diameter = 0.2 * proxy.size.width
                Circle()
                    .fill(Color.bubbleBackground)
                    .frame(width: diameter, height: diameter)
            }
        }
    }
}

struct WheelView_Previews: PreviewProvider {
    static var previews: some View {
        WheelView(options: ["Lana", "Jane", "Mary", "Jess", "Lisa"])
            .padding()
    }
}
