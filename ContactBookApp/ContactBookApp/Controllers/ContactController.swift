//
//  ContactController.swift
//  ContactBookApp
//
//  Created by antikiller on 4/5/23.
//

import Foundation
import UIKit


class ContactController {
    
    static func fetchContacts(completion: @escaping (Result<[Contact], ContactError>)  -> Void){
        
        guard let baseURL = URL(string: "http://localhost:5000/contacts") else {
            return completion(.failure(.invalidURL))
        }
        
        URLSession.shared.dataTask(with: baseURL) { data, response, error in
            
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            
            guard let response = response  as? HTTPURLResponse, response.statusCode == 200 else {
                return completion(.failure(.badResponse))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do{
                
                let arrayOfContacts = try JSONDecoder().decode([Contact].self, from: data)
                
                return completion(.success(arrayOfContacts))
                
            }catch{
                
                completion(.failure(.unableToDecode))
                
            }

            
        }.resume()
        
    }
    
    
}
