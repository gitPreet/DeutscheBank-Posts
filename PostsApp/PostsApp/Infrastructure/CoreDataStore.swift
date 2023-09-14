//
//  CoreDataStore.swift
//  PostsApp
//
//  Created by Preetham Baliga on 14/09/23.
//

import Foundation
import CoreData

public class CoreDataStore {

    private static let modelName = "UserPostsStore"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataStore.self))

    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext

    enum StoreError: Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Error)
    }

    public init(storeURL: URL) throws {

        guard let model = CoreDataStore.model else {
            throw StoreError.modelNotFound
        }

        do {
            container = try NSPersistentContainer.load(name: CoreDataStore.modelName, model: model, url: storeURL)
            context = container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }

    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }

    private func cleanUpReferencesToPersistentStores() {
         context.performAndWait {
             let coordinator = self.container.persistentStoreCoordinator
             try? coordinator.persistentStores.forEach(coordinator.remove)
         }
     }

    func clearCoreDataStore() {
        let storeCoordinator = self.container.persistentStoreCoordinator
        if let store = storeCoordinator.persistentStores.first {
        let storeURL = storeCoordinator.url(for: store)
            do {
                try storeCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
            } catch {
                print("Error clearing CoreData store: \(error)")
            }
        }
    }

     deinit {
         cleanUpReferencesToPersistentStores()
     }
}
