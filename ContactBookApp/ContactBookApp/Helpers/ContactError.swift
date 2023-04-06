//
//  ContactError.swift
//  ContactBookApp
//
//  Created by antikiller on 4/5/23.
//

import Foundation

enum ContactError: LocalizedError {
    
case invalidURL
case thrownError(Error)
case badResponse
case noData
case unableToDecode
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Unable to reach the server."
        case .thrownError(let error):
            return error.localizedDescription
        case .badResponse:
            return "The server sent back a bad response."
        case .noData:
            return "The server did not send back any data."
        case .unableToDecode:
            
            return "Unable to decode :("
        }
        
    }
}
