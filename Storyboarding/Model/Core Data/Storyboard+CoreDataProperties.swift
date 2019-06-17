//
//  Storyboard+CoreDataProperties.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 5/31/19.
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
    @NSManaged public var elements: NSSet?

}

// MARK: Generated accessors for elements
extension Storyboard {

    @objc(addElementsObject:)
    @NSManaged public func addToElements(_ value: Elements)

    @objc(removeElementsObject:)
    @NSManaged public func removeFromElements(_ value: Elements)

    @objc(addElements:)
    @NSManaged public func addToElements(_ values: NSSet)

    @objc(removeElements:)
    @NSManaged public func removeFromElements(_ values: NSSet)

}
