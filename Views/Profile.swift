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
                    Rectangle()
                        .frame(width: 500, height: 5)
                    
                    if let user = auth.user{
                        AsyncImage(url: user.photoURL)
                        //.resizable()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.black, lineWidth: 5))
                            .frame(width: 130, height: 130)
                            .offset(x: -90)
                    }
                    
                }
                
                
                Text("Brian Ashton")
                    .font(.system(size: 35, weight: .bold))
                    .offset(x: -75)
                
                Text("Posts:")
                    .font(.system(size: 30, weight: .bold))
                    .offset(x: -130, y: 200)
                
                
            }
            .offset(y: -275)
        }
    }
}

#Preview {
    Profile()
}
