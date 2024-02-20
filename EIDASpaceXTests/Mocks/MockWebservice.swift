import Foundation
@testable import EIDASpaceX

class MockWebservice: WebserviceProtocol {
    
    var retrieveLaunchesCalled = false
    var retrieveLaunchesResult = [EIDASpaceX.Launch]()
    func retrieveLaunches() async throws -> [EIDASpaceX.Launch] {
        retrieveLaunchesCalled = true
        return retrieveLaunchesResult
    }
    
    var retrieveCrewCalled = false
    var retrieveCrewResult = [EIDASpaceX.CrewMember]()
    func retrieveCrew() async throws -> [EIDASpaceX.CrewMember] {
        retrieveCrewCalled = true
        return retrieveCrewResult
    }
    
    var retrieveRocketsCalled = false
    var retrieveRocketsResult = [EIDASpaceX.Rocket]()
    func retrieveRockets() async throws -> [EIDASpaceX.Rocket] {
        retrieveRocketsCalled = true
        return retrieveRocketsResult
    }
}
