//
//  MovieEntity.swift
//  testP
//
//  Created by Дмитрий Цветков on 13.09.2023.
//

import UIKit
import CoreData

@objc(MovieEntity)
class MovieEntity: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: AllEnums.entityNames(name: .MovieEntity).value)
    }

    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: AllEnums.entityNames(name: .MovieEntity).value), insertInto: CoreDataManager.shared.context)
    }
    
    @NSManaged public var photo: UIImage?
    @NSManaged public var title: String?
    @NSManaged public var idOfMovie: Int32
    @NSManaged public var releaseDate: String?
    @NSManaged public var budget: Int64
}

extension MovieEntity : Identifiable {

}
