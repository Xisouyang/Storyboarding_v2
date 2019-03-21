//
//  Requests.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/19/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

typealias HTTPParameters = [String: Any]?
typealias HTTPHeaders = [String: String]?

struct HTTPNetworkRequest {
    
    static let headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Host": "https://storyboarding-api.herokuapp.com"
    ]
    
    static func configureHTTPRequest(route: HTTPNetworkRoute, parameters: HTTPParameters, method: HTTPMethod, body: Data?) throws -> URLRequest {
        
//        guard let base = self.headers["Host"],  let url = URL(string: "\(base)\(route.rawValue)") else { throw HTTPNetworkError.missingURL }
        
        guard let urlTest = URL(string: "https://storyboarding-api.herokuapp.com/api/users/stories") else { fatalError("bad url") }
        var request = URLRequest(url: urlTest)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        try configureParameterAndHeaders(parameters: parameters, headers: headers, request: &request)
        
        return request
    }
    
    static func configureParameterAndHeaders(parameters: HTTPParameters?,
                                             headers: HTTPHeaders?,
                                             request: inout URLRequest) throws {
        do {
            if let headers = headers, let parameters = parameters {
                
                if parameters != nil {
                    try URLEncoder.encodeParameters(urlRequest: &request, parameters: parameters)
                }
                try URLEncoder.setHeaders(urlRequest: &request, headers: headers)
            }
            
        } catch {
            throw HTTPNetworkError.encodingFailed
        }
    
    }
    
}
