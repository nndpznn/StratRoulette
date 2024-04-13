//
//  Login.swift
//  FinalApp
//
//  Created by Adi Roitburg on 4/12/24.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var auth: StratAuth
    @State var login: Bool = false
    @State var viewBlog: Bool = false
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(width: 500, height: 1000)
                        .edgesIgnoringSafeArea(.all)
           
            
            VStack{
                Text("Strat Roulette")
                    .font(.system(size: 55, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .offset(x: 0, y: -150)
                    .glowBorder(color: .black, lineWidth: 10)
                
                Button(action: {
                    // Add action here
                }) {
                    Text("Sign In")
                        .font(.system(size: 25, weight: .medium))
                        .foregroundColor(.black) // Change text color to black
                        //.glowBorder(color: .white, lineWidth: 5)
                }
                .buttonStyle(PlainButtonStyle())
                .background(
                    Capsule()
                        .fill(Color.blue)
                        .frame(width: 300, height: 50) // Adjust width and height as needed
                        .glowBorder(color: .white, lineWidth: 10)
                )
                
                Button(action: {
                    // Add action here
                }) {
                    
                    Text("Help")
                        .font(.system(size: 25, weight: .medium))
                        .foregroundColor(.black) // Change text color to black
                        
                }
                
                .buttonStyle(PlainButtonStyle())
                .background(
                    Capsule()
                        .fill(Color.blue)
                        .frame(width: 300, height: 50) // Adjust width and height as needed
                        .glowBorder(color: .white, lineWidth: 10)
                )
                .offset(y: 50)
            }
            
                        
           
        }
       
    }
}

#Preview {
    Login()
}
