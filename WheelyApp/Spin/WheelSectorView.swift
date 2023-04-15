//
//  WheelSectorView.swift
//  WheelyApp
//
//  Created by Lana Shatonova on 14/04/23.
//

import SwiftUI

struct WheelSectorView: View {

    let text: String
    let startAngle: Angle
    let endAngle: Angle

    @State private var textHeight: CGFloat = 0

    var body: some View {
        CircleSector(startAngle: startAngle, endAngle: endAngle)
            .fill(Color.primaryPurple.opacity(.random(in: 0.1..<0.8)))
            .overlay {
                // Position text on an angle in the middle of the sector
                // Make sure text doesn't stretch futher than sector's borders
                GeometryReader { circleProxy in
                    let angle = Angle(degrees: 0.5 * (startAngle.degrees + endAngle.degrees))
                    let radians = CGFloat(angle.radians)
                    let center = CGPoint(x: 0.5 * circleProxy.size.width,
                                         y: 0.5 * circleProxy.size.height)
                    let radius = 0.5 * circleProxy.size.width
                    let centerOffsetWidth = 0.3 * radius
                    let edgeOffsetWidth = 0.15 * radius
                    let textWidth = radius - centerOffsetWidth - edgeOffsetWidth

                    Text(text)
                        .font(.body)
                        .foregroundColor(.darkText)
                        .lineLimit(1)
                        .frame(width: textWidth, alignment: .trailing)
                        .rotationEffect(angle, anchor: .leading)
                        .offset(x: center.x + centerOffsetWidth * cos(radians),
                                y: center.y + centerOffsetWidth * sin(radians) - 0.5 * textHeight)
                        .background {
                            // Dynamically calculate text height
                            GeometryReader { textProxy in
                                Color.clear
                                    .onAppear {
                                        textHeight = textProxy.size.height
                                    }
                            }
                        }
                }
            }
    }
}

struct WheelSectorView_Previews: PreviewProvider {
    static var previews: some View {
        WheelSectorView(text: "Option", startAngle: .degrees(0), endAngle: .degrees(90))
            .padding()
    }
}
