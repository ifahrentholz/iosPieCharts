//
//  PieceOfPie.swift
//  PieChart
//
//  Created by Ingo Fahrentholz on 13.02.21.
//

import SwiftUI

struct PieceOfPie: Shape {
  let startDegree: Double
  let endDegree: Double
  
  func path(in rect: CGRect) -> Path {
    Path {p in
      let center = CGPoint(x: rect.midX, y: rect.midY)
      p.move(to: center)
      p.addArc(
        center: center,
        radius: rect.width / 2,
        startAngle: Angle(degrees: startDegree),
        endAngle: Angle(degrees: endDegree),
        clockwise: false
      )
      p.closeSubpath()
    }
  }
  
  
}
