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
        Text("Strat Roulette")
            .font(.system(size: 30, weight: .bold))
        Spacer()
       
    }
}

#Preview {
    Login()
}
