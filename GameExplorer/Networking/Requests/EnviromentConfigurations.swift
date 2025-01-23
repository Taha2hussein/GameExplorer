//
//  EnviromentConfigurations.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import Foundation
enum EnviromentConfigurations: String {
    case baseUrl = "https://www.gamerpower.com/api/giveaways"
    var value : String {
        get {
            return Bundle.main.infoDictionary![self.rawValue] as! String
        }
    }
}
