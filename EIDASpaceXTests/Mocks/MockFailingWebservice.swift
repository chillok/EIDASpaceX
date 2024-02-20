import Foundation
@testable import EIDASpaceX

enum MockError: Error {
    case error
}

class MockFailingWebservice: WebserviceProtocol {
    
    var retrieveLaunchesCalled = false
    var retrieveLaunchesResult = [EIDASpaceX.Launch]()
    func retrieveLaunches() async throws -> [EIDASpaceX.Launch] {
        retrieveLaunchesCalled = true
        throw MockError.error
    }
    
    var retrieveCrewCalled = false
    var retrieveCrewResult = [EIDASpaceX.CrewMember]()
    func retrieveCrew() async throws -> [EIDASpaceX.CrewMember] {
        retrieveCrewCalled = true
        throw MockError.error
    }
    
    var retrieveRocketsCalled = false
    var retrieveRocketsResult = [EIDASpaceX.Rocket]()
    func retrieveRockets() async throws -> [EIDASpaceX.Rocket] {
        retrieveRocketsCalled = true
        throw MockError.error
    }
}

