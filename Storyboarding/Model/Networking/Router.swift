//
//  Router.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 5/3/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

// allow us to select which option we want, and based on that will piece together URL
enum Router {
    case getAllStories
    
    var scheme: String {
        switch self {
        case .getAllStories:
            return "https"
        }
    }
        
    var host: String {
        switch self {
        case .getAllStories:
            return "storyboarding-api.herokuapp.com"
        }
    }
        
    var path: String {
        switch self {
        case .getAllStories:
            return "/api/users/stories"
        }
    }
        
    var method: String {
        switch self {
        case .getAllStories:
            return "GET"
        }
    }
}
