import Foundation

class RocketViewViewModel: Codable, Identifiable {
    
    var id: String
    var name: String
    var stages: Int
    var details: String
    var images: [String]
    
    init(id: String, name: String, stages: Int, details: String, images: [String]) {
        self.id = id
        self.name = name
        self.stages = stages
        self.details = details
        self.images = images
    }
}
