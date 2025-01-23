//
//  GameAPIEndPoint.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import Foundation
import Foundation
import Moya

enum GamesExplorerPIEndPoint {
    case gamesList
    case gameSearch(query: String)
}

extension GamesExplorerPIEndPoint: APIEndpoint {
    var baseURL: URL {
        return URL(string: EnviromentConfigurations.baseUrl.rawValue)!
    }
    
    var path: String {
        switch self {
        case .gamesList:
            return  ""
        case .gameSearch:
            return ""
      
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .gamesList,.gameSearch:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .gamesList:
            return .requestPlain
        case .gameSearch(let query):
            let urlParameters: [String: Any] = [
                "platform": query
            ]
            return .requestParameters(parameters: urlParameters, encoding: .queryString)
            
       
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .gamesList,.gameSearch:
            return HeadersRequest.shared.getHeaders(type: .normal)
        }
    }
}
