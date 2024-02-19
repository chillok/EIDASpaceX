import Foundation

struct LaunchToViewModelMapper {
    
    // we'll create local formatters to save on performance, as they're expensive to create
    
    let utcISOFormatter: ISO8601DateFormatter = {
        let fotmatter = ISO8601DateFormatter()
        fotmatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds ]
        return fotmatter
    }()
    
    let localISOFormatter: ISO8601DateFormatter = {
        let fotmatter = ISO8601DateFormatter()
        return fotmatter
    }()
    
    func map(launch item: Launch) -> LaunchViewViewModel {
        
        var dateUTC: Date?
        if let dateUTCString = item.dateUTC {
            dateUTC = utcISOFormatter.date(from: dateUTCString)
        }
        
        var dateLocal: Date?
        if let dateLocalString = item.dateLocal {
            dateLocal = localISOFormatter.date(from: dateLocalString)
        }
        
        return .init(id: item.id,
                     flightNumber: item.flightNumber,
                     name: item.name,
                     dateUTC: dateUTC,
                     dateLocal: dateLocal,
                     details: item.details,
                     success: item.success,
                     upcoming: item.success,
                     patch: item.patch,
                     crew: item.crew,
                     rocket: item.rocket)
    }
}
