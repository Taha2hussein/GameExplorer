//
//  moyaProvider.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import Foundation
import Moya


let moyaProvider = NetworkClient(transport: MoyaProvider<MoyaAPI>(plugins: [NetworkLoggerPlugin()]))
