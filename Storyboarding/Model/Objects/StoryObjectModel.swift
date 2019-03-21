//
//  StoryObjectModel.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 3/19/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

struct StoryModel: Codable {
    let genre: String?
    let plot: String?
    let conflict: String?
    let resolution: String?
    let character: String?
    let setting: String?
}

//struct StoryList: Codable {
//    let stories: [StoryModel]
//}
