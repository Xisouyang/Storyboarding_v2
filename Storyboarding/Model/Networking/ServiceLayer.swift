//
//  ServiceLayer.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 5/3/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

enum Result<T>{
    case success([StoryModel])
    case failure
}

class ServiceLayer {
    
    //generic class function that is codable (need to pull data from api, convert to object)
    class func request<T: Codable>(router: Router, completion: @escaping (Result<T>) ->()) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print(error.debugDescription)
                completion(.failure)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("bad status code: \(response.statusCode)")
                    completion(.failure)
                }
                guard let responseData = data else {
                    print("bad response data: \(String(describing: data))")
                    completion(.failure)
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let responseObj = try jsonDecoder.decode([StoryModel].self, from: responseData)
                    print(responseObj)
                    completion(.success(responseObj))
                } catch {
                    print("unable to decode")
                    completion(.failure)
                }
            }
        }
        dataTask.resume()
    }
}
