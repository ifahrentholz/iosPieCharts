//
//  ContentView.swift
//  Shared
//
//  Created by Ingo Fahrentholz on 13.02.21.
//

import SwiftUI

// Model
enum Asset {
  case equity, cash, bond, realEstate
}

struct AssetAllocation{
  let asset: Asset
  let percentage: Double
  let description: String
  let color: Color
}

// ViewModel
final class PieChartViewModel: ObservableObject {
  @Published var data: [AssetAllocation] = [
    AssetAllocation(
      asset: .cash, percentage: 0.1, description: "Cash", color: Color("cGreen")
    ),
    AssetAllocation(
      asset: .equity, percentage: 0.4, description: "Stocks", color: Color("cPink")
    ),
    AssetAllocation(
      asset: .bond, percentage: 0.3, description: "Bonds", color: Color("cPurple")
    ),
    AssetAllocation(
      asset: .realEstate, percentage: 0.2, description: "Real Estate", color: Color("cRed")
    ),
  ]
}

// Views
struct ContentView: View {
  var body: some View {
    PieChart()
  }
}

struct PieChart: View {
  @ObservedObject var viewModel = PieChartViewModel();
  var body: some View {
    ZStack {
      ForEach(0..<viewModel.data.count) { index
        in
        let currentData = viewModel.data[index]
        let currentEndDegree = currentData.percentage * 360
        let lastDegree = viewModel.data.prefix(index).map{
          $0.percentage
        }.reduce(0, +) * 360
        
        ZStack {
          PieceOfPie(startDegree: lastDegree, endDegree: lastDegree + currentEndDegree).fill(currentData.color)
          GeometryReader { geometry in
            Text(currentData.description)
              .font(.custom("Avenir", size: 20))
              .foregroundColor(.white)
              .position(getLabelCoordinate(in: geometry.size, for: lastDegree + (currentEndDegree / 2)))
          }
        }
      }
    }
  }
  
  private func getLabelCoordinate(in geoSize: CGSize, for degree: Double) -> CGPoint {
    let center = CGPoint(x: geoSize.width / 2, y: geoSize.height / 2)
    let radius = geoSize.width / 3
    let yCoordinate = radius * sin(CGFloat(degree) * CGFloat.pi / 180)
    let xCorrdinate = radius * cos(CGFloat(degree) * CGFloat.pi / 180)
    return CGPoint(x: center.x + xCorrdinate, y: center.y + yCoordinate)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
