//
//  CircleSector.swift
//  WheelyApp
//
//  Created by Lana Shatonova on 14/04/23.
//

import SwiftUI

struct CircleSector: Shape {

    let startAngle: Angle
    let endAngle: Angle

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = 0.5 * rect.width
        let radians = CGFloat(startAngle.radians)

        var path = Path()
        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x + radius * cos(radians),
                                 y: center.y + radius * sin(radians)))
        path.addArc(center: center, radius: radius,
                    startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        return path
    }
}

struct CircleSector_Previews: PreviewProvider {
    static var previews: some View {
        CircleSector(startAngle: .degrees(0), endAngle: .degrees(90))
            .padding()
    }
}
