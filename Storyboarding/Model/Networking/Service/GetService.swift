//
//  GetService.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/19/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

struct GetServices {
    
    let getSession = URLSession(configuration: .default)
    
    let request = URLRequest(url: URL(string: "https://storyboarding-api.herokuapp.com/api/users/stories")!)
    
    func getStories(completion: @escaping (Result<[StoryModel]>)->()) {
        
        do {
            //TODO: Replace hardcoded url with dynamically generated url
//          let request = try HTTPNetworkRequest.configureHTTPRequest(route: .getAllStories, parameters: nil, method: .get, body: nil)
            
            getSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                        
                    case .success:
                        let result = try? JSONDecoder().decode([StoryModel].self, from: unwrappedData)
                        completion(Result.success(result!))
                    case .failure:
                        completion(Result.failure(HTTPNetworkError.badRequest))
                    }
                }
            }.resume()
        }
//        catch {
//            completion(Result.failure(HTTPNetworkError.badRequest))
//        }
    }
}
