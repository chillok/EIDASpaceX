import Foundation

/// Used for showing Launch information in UI
class LaunchViewViewModel: Identifiable {
    var id: String
    var flightNumber: Int
    var name: String
    var dateUTC: Date?
    var dateLocal: Date?
    var details: String?
    var success: Bool?
    var upcoming: Bool?
    var patch: String?
    var crew: [String]?
    var rocket: String?
    
    init(id: String,
         flightNumber: Int,
         name: String,
         dateUTC: Date? = nil,
         dateLocal: Date? = nil,
         details: String? = nil,
         success: Bool? = nil,
         upcoming: Bool? = nil,
         patch: String? = nil,
         crew: [String]? = nil,
         rocket: String? = nil) {
        
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
}
