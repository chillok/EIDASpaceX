import Foundation
import SwiftData

@Model
/// Used for Launch persistence and API
class Launch: Codable, Identifiable, ObservableObject {
    
    @Attribute(.unique) var id: String
    var flightNumber: Int
    var name: String
    var dateUTC: String?
    var dateLocal: String?
    var details: String?
    var success: Bool?
    var upcoming: Bool?
    var patch: String?
    var crew: [String]?
    var rocket: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case flightNumber = "flight_number"
        case name
        case dateUTC = "date_utc"
        case dateLocal = "date_local"
        case details
        case success
        case upcoming
        case links
        case crew
        case rocket
    }
    
    private enum LinksCodingKeys: String, CodingKey {
        case patch
    }
    
    private enum PatchCodingKeys: String, CodingKey {
        case large, small
    }
    
    init(id: String,
         flightNumber: Int,
         name: String,
         dateUTC: String,
         dateLocal: String,
         details: String?,
         success: Bool?,
         upcoming: Bool?,
         patch: String?,
         crew: [String]?,
         rocket: String?) {
        
        self.id = id
        self.flightNumber = flightNumber
        self.name = name
        self.dateUTC = dateUTC
        self.dateLocal = dateLocal
        self.details = details
        self.success = success
        self.upcoming = upcoming
        self.patch = patch
        self.crew = crew
        self.rocket = rocket
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.flightNumber = try container.decode(Int.self, forKey: .flightNumber)
        self.name = try container.decode(String.self, forKey: .name)
        self.dateUTC = try container.decodeIfPresent(String.self, forKey: .dateUTC)
        self.dateLocal = try container.decodeIfPresent(String.self, forKey: .dateLocal)
        self.details = try container.decodeIfPresent(String.self, forKey: .details)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.upcoming = try container.decodeIfPresent(Bool.self, forKey: .upcoming)
        
        let linksContainer = try container.nestedContainer(keyedBy: LinksCodingKeys.self, forKey: .links)
        let patchContainer = try linksContainer.nestedContainer(keyedBy: PatchCodingKeys.self, forKey: .patch)
        self.patch = try patchContainer.decodeIfPresent(String.self, forKey: .small)
        
        self.crew = try container.decodeIfPresent([String].self, forKey: .crew)
        self.rocket = try container.decodeIfPresent(String.self, forKey: .rocket)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(flightNumber, forKey: .flightNumber)
        try container.encode(name, forKey: .name)
        try container.encode(dateUTC, forKey: .dateUTC)
        try container.encode(dateLocal, forKey: .dateLocal)
        try container.encode(details, forKey: .details)
        try container.encode(success, forKey: .success)
        try container.encode(upcoming, forKey: .upcoming)
        
        var linksContainer = container.nestedContainer(keyedBy: LinksCodingKeys.self, forKey: .links)
        try linksContainer.encode(patch, forKey: .patch)
        
        try container.encode(crew, forKey: .crew)
        try container.encode(rocket, forKey: .rocket)
    }
}
