//
//  Profile.swift
//  FinalApp
//
//  Created by Adi Roitburg on 4/17/24.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var auth: StratAuth
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(width: 500, height: 2000)
                        .edgesIgnoringSafeArea(.all)
                    
                    Rectangle()
                        .frame(width: 500, height: 5)
                       
                    
                    
                    Image("guy")
                        .resizable()
                        .clipShape(Circle())
                       
                        .overlay(Circle().stroke(Color.black, lineWidth: 5))
                        .frame(width: 130, height: 130)
                        .offset(x: -90)
                    
                    if let user = auth.user{
                        Text(user.displayName ?? "")
                            .font(.system(size: 35, weight: .bold))
                            .offset(x: -75, y: 100)
                            .foregroundColor(.white)
                            .glowBorder(color: .black, lineWidth: 7)
                    }
                    
                                            
                    Text("Posts:")
                        .font(.system(size: 20, weight: .bold))
                        .offset(x: -130, y: 200)
                        .foregroundColor(.white)
                        .glowBorder(color: .black, lineWidth: 7)
                    
                    
                }
                .offset(y: -275)
            }
            
        }
    }
}

#Preview {
    Profile()
        .environmentObject(StratAuth())
}
