import Foundation
import SwiftData

@Model
class Rocket: Codable, Identifiable {
    
    var id: String
    var name: String
    var stages: Int
    var details: String
    var images: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, stages, details = "description", images = "flickr_images"
    }
    
    init(id: String, name: String, stages: Int, details: String, images: [String]) {
        self.id = id
        self.name = name
        self.stages = stages
        self.details = details
        self.images = images
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.details = try container.decode(String.self, forKey: .details)
        self.name = try container.decode(String.self, forKey: .name)
        self.stages = try container.decode(Int.self, forKey: .stages)
        self.images = try container.decode([String].self, forKey: .images)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(images, forKey: .images)
        try container.encode(stages, forKey: .stages)
        try container.encode(details, forKey: .details)
    }
}
