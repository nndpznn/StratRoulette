//
//  UserIcon.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/10/24.
//

import SwiftUI

struct UserIcon: View {
    var user: User
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .frame(width: 350, height: 100)
                .shadow(radius:2)
            HStack(alignment: .center) {
                Image(systemName:"person.circle")
                    .resizable()
                    .frame(width:50, height: 50)
                
                Spacer()
                
                VStack {
                    Text(user.username)
                        .font(.title)
                        .bold()
                }
            }
            .padding(40)
        }
    }
}

#Preview {
    UserIcon(user: exampleUser)
}

