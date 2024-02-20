import Foundation
@testable import EIDASpaceX

enum MockError: Error {
    case error
}

class MockFailingWebservice: WebserviceProtocol {
    
    var retrieveLaunchesCalled = false
    func retrieveLaunches() async throws -> [EIDASpaceX.Launch] {
        retrieveLaunchesCalled = true
        throw MockError.error
    }
    
    var retrieveCrewCalled = false
    func retrieveCrew() async throws -> [EIDASpaceX.CrewMember] {
        retrieveCrewCalled = true
        throw MockError.error
    }
    
    var retrieveRocketsCalled = false
    func retrieveRockets() async throws -> [EIDASpaceX.Rocket] {
        retrieveRocketsCalled = true
        throw MockError.error
    }
    
    var dataCalled = false
    func data(for request: URLRequest) async throws -> Data {
        dataCalled = true
        throw MockError.error
    }
}

