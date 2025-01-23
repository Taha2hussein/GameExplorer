//
//  Transport.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import Combine
import Foundation

protocol Transport {
    func send(endPoint: APIEndpoint) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error>
}
