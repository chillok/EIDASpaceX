import SwiftData
import Foundation

extension StorageProtocol {
    
    @MainActor
    func retrieve(id: String) -> CrewMember? {
        let predicate = #Predicate<CrewMember> { $0.id == id }
        let descriptor = FetchDescriptor(predicate: predicate)
        let result = try? modelContainer.mainContext.fetch(descriptor)
        return result?.first
    }
}
