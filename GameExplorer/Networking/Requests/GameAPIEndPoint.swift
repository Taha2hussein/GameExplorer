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
    case movieSearch(query: String)
    case movieDtail(movie_id: Int)
}

extension GamesExplorerPIEndPoint: APIEndpoint {
    var baseURL: URL {
        return URL(string: EnviromentConfigurations.baseUrl.rawValue)!
    }
    
    var path: String {
        switch self {
        case .gamesList:
            return  ""
        case .movieSearch:
            return "search/movie"
        case .movieDtail(let movie_id):
            return "/movie/\(movie_id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .gamesList,.movieSearch,.movieDtail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .gamesList:
            return .requestPlain
        case .movieSearch(let query):
            let urlParameters: [String: Any] = [
                "query": query
            ]
            return .requestParameters(parameters: urlParameters, encoding: .queryString)
            
        case .movieDtail(let movieId):
            return .requestPlain
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .gamesList,.movieSearch,.movieDtail:
            return HeadersRequest.shared.getHeaders(type: .normal)
        }
    }
}
