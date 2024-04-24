//
//  ProgrammableShape.swift
//  FinalApp
//
//  Created by Adi Roitburg on 4/24/24.
//

import SwiftUI

struct ProgrammableShape: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.brown)
               
            
            Circle()
                .fill(Color.white)
                .frame(width: 300, height: 300)
            
            Rectangle()
                .fill(Color.brown)
                .frame(width: 300, height: 30)
            
            Rectangle()
                .fill(Color.brown)
                .frame(width: 30, height: 300)
            
            Rectangle()
                .fill(Color.brown)
                .frame(width: 300, height: 30)
                .rotationEffect(.degrees(45))
            
            Rectangle()
                .fill(Color.brown)
                .frame(width: 300, height: 30)
                .rotationEffect(.degrees(-45))
            
//            Circle()
//                .frame(width: 30, height: 30)
            
            Rectangle()
                .fill(Color.brown)
                .frame(width: 100, height: 45)
                .rotationEffect(.degrees(45))
                .offset(x: 80, y: 190)
            
            
            Rectangle()
                .fill(Color.brown)
                .frame(width: 100, height: 45)
                .rotationEffect(.degrees(-45))
                .offset(x: -80, y: 190)
            
            

        }
       
    }
}

#Preview {
    ProgrammableShape()
}
