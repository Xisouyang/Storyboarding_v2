//
//  URLEncoder.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/19/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

struct URLEncoder {
    
    /* Encode and set parameters of a url request */
    
    static func encodeParameters(urlRequest: inout URLRequest, parameters: HTTPParameters?) throws {
        
        if parameters == nil { return }
        
        guard let url = urlRequest.url else {
            
            print(HTTPNetworkError.missingURL.rawValue)
            throw HTTPNetworkError.missingURL
        }
        
        guard let unwrappedParam = parameters else {
            
            print(HTTPNetworkError.parametersNil.rawValue)
            throw HTTPNetworkError.parametersNil
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !unwrappedParam!.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in unwrappedParam! {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded;", forHTTPHeaderField: "Content-Type")
        }
    }
    
    /* Set the addition http headers of the request */
    
    static func setHeaders(urlRequest: inout URLRequest, headers: HTTPHeaders) throws {
        guard let unwrappedHeader = headers else { throw HTTPNetworkError.headerFailed }
        for (key, value) in unwrappedHeader {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
}


