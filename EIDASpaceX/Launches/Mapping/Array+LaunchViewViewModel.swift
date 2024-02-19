import Foundation

extension Array where Element: LaunchViewViewModel {
    
    func sortedForLaunchView() -> [LaunchViewViewModel] {
        sorted { $0.flightNumber < $1.flightNumber }
    }
}
