//
//  UserIcon.swift
//  FinalApp
//
//  Created by Nolan Nguyen on 4/10/24.
//

import SwiftUI

struct UserIcon: View {
    var author: Author
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .frame(width: 325, height: 100)
                .shadow(radius:2)
            HStack(alignment: .center) {
                Image(systemName:"person.circle")
                    .resizable()
                    .frame(width:50, height: 50)
                
                Spacer()
                
                VStack {
                    Text(author.username)
                        .font(.title)
                        .bold()
                }
            }
            .padding(50)
        }
    }
}

#Preview {
    UserIcon(author: exampleUser)
}

