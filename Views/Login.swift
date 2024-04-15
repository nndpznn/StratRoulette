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
                
                // MARK: - If NOT logged in, show this screen
                if auth.user == nil{
                    Button(action: {
                        login = true
                    }) {
                        Text("Sign In")
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
                    .sheet(isPresented: $login) {
                        if let authUI = auth.authUI {
                            AuthViewController(authUI: authUI)
                        }
                    }
                    
                    Button(action: {
                        
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
                    
                    
                // MARK: - If logged in, show this screen
                } else  {
                    Button(action: {
                        //Action
                    }) {
                        Text("View App")
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
                    
                    Button(action: {
                        //Action
                    }) {
                        Text("View Profile")
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
                    
                    Button(action: {
                        login = false
                        do {
                            try auth.signOut()
                        } catch {
                            // Error handle
                        }
                        
                    }) {
                        Text("Sign Out")
                            .font(.system(size: 25, weight: .medium))
                            .foregroundColor(.black) // Change text color to black
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    .background(
                        Capsule()
                            .fill(Color.red)
                            .frame(width: 300, height: 50) // Adjust width and height as needed
                            .glowBorder(color: .white, lineWidth: 10)
                    )
                    .offset(y: 100)
                    
                    
                }
            }
            
                        
           
        }
       
    }
}

#Preview {
    Login()
}
