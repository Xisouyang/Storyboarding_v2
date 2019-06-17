//
//  Elements+CoreDataProperties.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 5/31/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//
//

import Foundation
import CoreData


extension Elements {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Elements> {
        return NSFetchRequest<Elements>(entityName: "Elements")
    }

    @NSManaged public var type: String?
    @NSManaged public var content: String?
    @NSManaged public var storyboard: Storyboard?

}
