import Foundation

extension Date {
    
    var readableDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy • HH:mm"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
}
