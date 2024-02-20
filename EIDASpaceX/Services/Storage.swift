import Foundation
import SwiftData

protocol StorageProtocol {
    
    func store<T: PersistentModel>(_ models: [T]) throws where T: Identifiable
    func retrieveAll<T: PersistentModel>() throws -> [T]
}

class Storage: StorageProtocol {
    
    static let shared = Storage()
    
    enum StorageError: Error {
        case retrievalError
        case storeError
    }
    
    var isStoredInMemoryOnly: Bool
    
    init(isStoredInMemoryOnly: Bool = false) {
        self.isStoredInMemoryOnly = isStoredInMemoryOnly
    }
    
    lazy var modelContainer: ModelContainer = {
        let schema = Schema([Launch.self, CrewMember.self, Rocket.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: isStoredInMemoryOnly)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    func store<T: PersistentModel>(_ models: [T]) throws where T: Identifiable {
        
        let context = ModelContext(modelContainer)
        
        do {
            // for simplicity we will delete all models each time we are about to store all new ones
            try context.delete(model: T.self)
            
            for model in models {
                context.insert(model)
            }
            
            try context.save()
        }
        catch {
            throw StorageError.storeError
        }
    }
    
    @MainActor
    func retrieveAll<T: PersistentModel>() throws -> [T] {
        do {
            return try modelContainer.mainContext.fetch(FetchDescriptor<T>())
        } catch {
            throw StorageError.retrievalError
        }
    }
}
