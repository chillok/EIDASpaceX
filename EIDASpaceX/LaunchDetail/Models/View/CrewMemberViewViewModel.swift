import Foundation

class CrewMemberViewViewModel: Codable, Identifiable {
    var id: String
    var name: String
    var image: String
    
    init(id: String, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
