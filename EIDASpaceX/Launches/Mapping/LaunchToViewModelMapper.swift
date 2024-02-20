import Foundation

struct LaunchToViewModelMapper {
    
    // we'll create local formatters to save on performance, as they're expensive to create
    
    let utcISOFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds ]
        return formatter
    }()
    
    let localISOFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
    
    func map(launch item: Launch) -> LaunchViewViewModel {
        
        var dateUTC: Date?
        if let dateUTCString = item.dateUTC {
            dateUTC = utcISOFormatter.date(from: dateUTCString)
        }
        
        var dateLocal: Date?
        if let dateLocalString = item.dateLocal {
            
            let trimmed = String(dateLocalString.dropLast(6))
            dateLocal = localISOFormatter.date(from: trimmed)
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
