//
//  Character.swift
//  Marvel
//
//  Created by User14 on 2022/12/27.
//

import SwiftUI


struct APIResult : Codable{
    var data: APICharacterData
}
struct APICharacterData : Codable{
    var count:Int
    var results: [Character]
    
}
struct Character: Identifiable,Codable {
    

    var id : Int
    var name : String
    var description : String
    var thumbnail :[String:String]
    var urls: [[String:String]]

   
}

