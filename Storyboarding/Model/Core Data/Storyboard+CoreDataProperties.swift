//
//  Storyboard+CoreDataProperties.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 5/30/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//
//

import Foundation
import CoreData


extension Storyboard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Storyboard> {
        return NSFetchRequest<Storyboard>(entityName: "Storyboard")
    }

    @NSManaged public var title: String?
    @NSManaged public var elements: Elements?

}
