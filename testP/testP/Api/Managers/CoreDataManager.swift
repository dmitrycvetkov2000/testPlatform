//
//  CacheManager.swift
//  testP
//
//  Created by Дмитрий Цветков on 13.09.2023.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    private init() { ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName("UIImageTransformer"))}
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    // Описание сущности
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context) ?? NSEntityDescription()
    }
    
    func isEmptyCoreData() -> Bool {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: AllEnums.entityNames(name: .MovieEntity).value)
        do {
            let results = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            guard !results.isEmpty else { return true }
            
//                for result in results as! [MovieEntity] {
//                    print("В базе данных:  Photo - \(String(describing: result.photo)), Title - \(String(describing: result.title))")
//                }
                return false
                        
        } catch {
            print(error)
            return true
        }
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Error of save \(nserror)")
            }
        }
    }
    
    func getElementFromBD<T>(findKey: AllEnums) -> [T] {
        var elements: [T] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: AllEnums.entityNames(name: .MovieEntity).value)
        do {
            if let results =  try CoreDataManager.shared.context.fetch(fetchRequest) as? [MovieEntity] {
                for result in results {
                    if let searchElement = result.value(forKey: findKey.value) as? T {
                        elements.append(searchElement)
                    }
                }
            }
        } catch {
            print(error)
        }
        return elements
    }
    
    func insert<T: NSManagedObject>(object: T) {
        let context = persistentContainer.viewContext
        context.insert(object)
        self.saveContext()
    }
    
    func cacheMovie(urlString: String, text: String, id: Int) {
        APIManager.shared.loadImage(urlString: urlString) { image in
            let new = MovieEntity()
            new.title = text
            new.photo = image
            new.idOfMovie = Int32(id)
            
            DispatchQueue.main.async {
                CoreDataManager.shared.insert(object: new)
            }
        }
    }
    
    func getAllEntity(entityName: AllEnums) -> [AnyObject] {
        var masEntity: [AnyObject] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.value)
        do {
            let results = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            guard !results.isEmpty else { return [] }
            
                for result in results as! [MovieEntity] {
                    masEntity.append(result)
                }
        } catch {
            print(error)
        }
        return masEntity
    }
    
    func deleteAllEntity(entityName: AllEnums) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.value)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try CoreDataManager.shared.persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: CoreDataManager.shared.context)
            saveContext()
        } catch let error as NSError {
            print(error)
        }
    }
}
