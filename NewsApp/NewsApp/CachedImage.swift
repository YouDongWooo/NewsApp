//
//  CachedImage.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import UIKit
import CoreData

@objc(CachedImage)
class CachedImage: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedImage> {
        return NSFetchRequest<CachedImage>(entityName: "CachedImage")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var image: UIImage?
}

extension CachedImage : Identifiable {

}
