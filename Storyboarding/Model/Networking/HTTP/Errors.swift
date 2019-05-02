//
//  Errors.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/18/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

enum HTTPNetworkError: String, Error {
    
    case parametersNil = "Error Found : Parameters URL were nil."
    case encodingFailed = "Error Found : Parameter Encoding failed."
    case decodingFailed = "Error Found : Unable to Decode the data."
    case missingURL = "Error Found : The URL is nil."
    case couldNotParse = "Error Found : Unable to parse the JSON response."
    case noData = "Error Found : The data from API is Nil."
    case FragmentResponse = "Error Found : The API's response's body has fragments."
    case UnwrappingError = "Error Found : Unable to unwrape the data."
    case dataTaskFailed = "Error Found : The Data Task object failed."
    case success = "Successful Network Request"
    case authenticationError = "Error Found : You must be Authenticated"
    case badRequest = "Error Found : Bad Request"
    case pageNotFound = "Error Found : Page/Route requested not found."
    case failed = "Error Found : Network Request failed"
    case serverSideError = "Error Found : Server error"
    case headerFailed = "Error Found : Unwrapping header failed"
}
