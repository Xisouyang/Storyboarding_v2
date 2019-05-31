//
//  Elements+CoreDataProperties.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 5/30/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//
//

import Foundation
import CoreData


extension Elements {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Elements> {
        return NSFetchRequest<Elements>(entityName: "Elements")
    }

    @NSManaged public var plot: String?
    @NSManaged public var conflict: String?
    @NSManaged public var resolution: String?
    @NSManaged public var character: String?
    @NSManaged public var setting: String?
    @NSManaged public var storyboard: Storyboard?

}
