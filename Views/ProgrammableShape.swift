//
//  ProgrammableShape.swift
//  FinalApp
//
//  Created by Adi Roitburg on 4/27/24.
//

import SwiftUI

//Triangle helper shape for coloring in the sections of the roulette wheel
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

//Donut helper shape for the outer circle of the roulette wheel
struct Donut: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var holeRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius - holeRadius

        path.addArc(center: center, radius: outerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.addArc(center: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)

        path.closeSubpath()

        return path
    }
}

struct ProgrammableShape: View {
    @State private var rotationAngle: Double = 0.0
    @State private var isRotated: Bool = false
    
    var animatableData: Bool { //credit to: https://www.hackingwithswift.com/books/ios-swiftui/animating-simple-shapes-with-animatabledata
        get { isRotated }
        set { isRotated = newValue }
    }
    
    var body: some View {
        ZStack { //Full shape
            ZStack { //Inner section
                Triangle()
                    .fill(Color.yellow)
                    .frame(width: 140, height: 155)
                    .rotationEffect(.degrees(25))
                    .offset(x: -40, y: 80)
                
                Triangle()
                    .fill(Color.red)
                    .frame(width: 140, height: 155)
                    .rotationEffect(.degrees(205))
                    .offset(x: 30, y: -70)
                
                Triangle()
                    .fill(Color.orange)
                    .frame(width: 140, height: 155)
                    .rotationEffect(.degrees(155))
                    .offset(x: -30, y: -70)
                
                Triangle()
                    .fill(Color.blue)
                    .frame(width: 140, height: 155)
                    .rotationEffect(.degrees(335))
                    .offset(x: 40, y: 80)
                
                Triangle()
                    .fill(Color.pink)
                    .frame(width: 140, height: 155)
                    .rotationEffect(.degrees(115))
                    .offset(x: -75, y: -21)
                
                
                Triangle()
                    .fill(Color.green)
                    .frame(width: 140, height: 155)
                    .rotationEffect(.degrees(295))
                    .offset(x: 75, y: 21)
                
                Triangle()
                    .fill(Color.cyan)
                    .frame(width: 140, height: 155)
                    .rotationEffect(.degrees(75))
                    .offset(x: -65, y: 35)
                
                Triangle()
                    .fill(Color.purple)
                    .frame(width: 140, height: 155)
                    .rotationEffect(.degrees(255))
                    .offset(x: 65, y: -35)
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 300, height: 30)
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 30, height: 300)
                    
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 300, height: 30)
                    .rotationEffect(.degrees(45))
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 300, height: 30)
                    .rotationEffect(.degrees(-45))
                    
            }.rotationEffect(Angle.degrees(isRotated ? 360 : 720), anchor: .center)
                .onAppear {
                    withAnimation(Animation.linear(duration: 2.0)) {
                        isRotated = true
                    }
                }
            
            Donut(startAngle: .degrees(0), endAngle: .degrees(360), holeRadius: 47)
        }
    }
}

struct ProgrammableShape_Previews: PreviewProvider {
    static var previews: some View {
        ProgrammableShape()
    }
}
