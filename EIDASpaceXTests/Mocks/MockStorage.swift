import Foundation
import SwiftData
@testable import EIDASpaceX

class MockStorage: StorageProtocol {

    var storeCalled = false
    var storeParams = [any PersistentModel]()
    func store<T>(_ models: [T]) throws where T : PersistentModel {
        storeCalled = true
        storeParams = models
    }
    
    var retrieveAllCalled = false
    var retrieveAllResult = [any PersistentModel]()
    func retrieveAll<T>() throws -> [T] where T : PersistentModel {
        retrieveAllCalled = true
        return retrieveAllResult as! [T]
    }
}
