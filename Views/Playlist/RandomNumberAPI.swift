//
//  RandomNumberAPI.swift
//  FinalApp
//
//  Created by Dylan Suzuki on 4/29/24.
//

import Foundation

//Base URL Variable
func getURL(max: Int) -> String{
    return "https://www.randomnumberapi.com/api/v1.0/random?min=0&max=\(max)&count=1"
}

func getRandomNumber(count: Int) async throws -> Int{
    //Getting URL based on the length of the challenge list
    guard let fullURL = URL(string: getURL(max: count)) else{
        fatalError("Invalid URL")
    }
    print("\n", fullURL, "\n")
    
    let (data, _) = try await URLSession.shared.data(from: fullURL)
    var dataString = String(data: data, encoding: .utf8)!
    
    //Pulling off the non-numerical string data from the API call
    dataString = dataString.replacingOccurrences(of: "[", with: "")
    dataString = dataString.replacingOccurrences(of: "]", with: "")
    dataString = dataString.replacingOccurrences(of: "\n", with: "")
    
    //Converting to an int
    let dataInt = Int(dataString)
    
    print("Data: |", dataString, "|\n\n")

    
    return dataInt ?? 69
}
