import Foundation
import SwiftData

@Model
class Patch: Codable {
    var small: String?
    var large: String?
    
    enum CodingKeys: String, CodingKey {
        case small, large
    }
    
    init(small: String, large: String) {
        self.small = small
        self.large = large
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.small = try container.decodeIfPresent(String.self, forKey: .small)
        self.large = try container.decodeIfPresent(String.self, forKey: .large)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(small, forKey: .small)
        try container.encode(large, forKey: .large)
    }
}
