//
//  Service.swift
//  GedditChallenge
//
//  Created by Chace Teera on 17/02/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {

    
    static let shared = NetworkService()

    
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
    

    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        let parameters: [String: Any] = [
            "email": email,
            "password": password

        ]
        
        
        AF.request("https://api.live.dev.gedditlive.com/v1/test/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                    .responseJSON { response in
                            switch response.result {
                            case .success(let value):
                                
                                completion(nil)
                            case .failure(let error):

                                completion(nil)
                            }
                        }

    }

}
