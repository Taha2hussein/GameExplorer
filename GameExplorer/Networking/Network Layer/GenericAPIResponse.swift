//
//  GenericAPIResponse.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import Foundation
struct GenericAPIResponse<T: Codable>: Codable {
    let result: Response<T>?
}

struct Response<T: Codable>: Codable {
    let status: Bool?
    let data: T?
}

