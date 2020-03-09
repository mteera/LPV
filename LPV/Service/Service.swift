//
//  Service.swift
//  GedditChallenge
//
//  Created by Chace Teera on 17/02/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import Foundation
import Alamofire

class Service {

    
    static let shared = Service()
    
    var products = [Product]()
    
    
    // declare my generic json function here
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
    
    func postAction(completion: @escaping (Error?)-> Void) {
        let Url = String(format: "https://api.live.dev.gedditlive.com/v1/test/login/")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameter = ["email" : "​candidate@geddit.com", "password" : "becoolatgeddit"]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else {

            return
        }
        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
                
            }
            if let data = data {
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                    
                    print(json)
                    completion(nil)

                } catch {
                    
                    completion(error)
                }
            }
            }.resume()
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?)-> Void) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        let parameters: [String: Any] = [
            "email": email,
            "password": password

        ]
        
        
        AF.request("https://api.live.dev.gedditlive.com/v1/test/login/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                            switch response.result {
                            case .success(let value):
                                print(value)
                                
                                completion(nil)
                            case .failure(let error):
                                completion(error)
                            }
                        }

    }

}
