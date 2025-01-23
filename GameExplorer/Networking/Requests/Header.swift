//
//  Header.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import Foundation
enum HeaderType {
    case normal
    case refreshToken
}

class HeadersRequest {
    static let shared = HeadersRequest()
    
    func getHeaders(type: HeaderType) -> [String: String] {
        var httpHeaders = [String: String]()
        
        if type == .normal {
            httpHeaders = [
                "Accept":"application/json",
                "Accept-Language":"en",
                "Content-Type":"application/json",
                "Authorization": ""
          
            ]
        } else if type == .refreshToken {
            httpHeaders = [
                "Accept":"application/json",
                "Accept-Language":"en",
                "Content-Type":"application/json",
                "Authorization": ""
            ]
        }
        
        return httpHeaders
    }
}
