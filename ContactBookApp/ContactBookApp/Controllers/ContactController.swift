//
//  ContactController.swift
//  ContactBookApp
//
//  Created by antikiller on 4/5/23.
//

import Foundation
import UIKit


class ContactController {
    
    static let baseUrl = URL(string: "http://localhost:5000/")!
    
    //getting contacts
    static func fetchContacts(completion: @escaping (Result<[Contact], ContactError>)  -> Void){
        
        URLSession.shared.dataTask(with: baseUrl.appendingPathComponent("contacts")) { data, response, error in
            
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
    
    //adding contact
    static func addContact(contactName: String, contactPhone: String, contactEmail: String, completion: @escaping (Result<Contact, ContactError>)  -> Void){
        
        var request = URLRequest(url: baseUrl.appendingPathComponent("contact"))
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "name": contactName,
            "phone": contactPhone,
            "email": contactEmail
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            
            guard let response = response  as? HTTPURLResponse, response.statusCode < 300 else {
                return completion(.failure(.badResponse))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do{
                
                let contact = try JSONDecoder().decode(Contact.self, from: data)
                
                return completion(.success(contact))
                
            }catch{
                
                completion(.failure(.unableToDecode))
                
            }
            
          
            
        }.resume()
        
    }
    
    
    //deleting contact
    static func deleteContact(contactId: Int, completion: @escaping (Result<Void, ContactError>)  -> Void){
        
        var request = URLRequest(url: baseUrl.appendingPathComponent("contacts/").appendingPathComponent(String(contactId)))
        request.httpMethod = "DELETE"
        
        print("ContactID")
        print(contactId)
        print(request)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            
            guard let response = response  as? HTTPURLResponse, response.statusCode < 300 else {
                return completion(.failure(.badResponse))
            }
            
            return completion(.success(()))
        }.resume()
        
    }
        
    
}
