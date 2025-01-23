//
//  Client.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import Combine
import Foundation

protocol Client {
    func performRequest<T: Decodable>(
        api: APIEndpoint,
        decodeTo: T.Type
    ) -> AnyPublisher<T, APIError>
    
    func performRequest(
        api: APIEndpoint
    ) -> AnyPublisher<Data, APIError>
}

protocol HasClient {
    var client: Client { get }
}
