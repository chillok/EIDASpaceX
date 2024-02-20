import Foundation
@testable import EIDASpaceX

class MockDataWebservice: Webservice {
    
    var dataCalled = false
    var dataResult = Data()
    override func data(for request: URLRequest) async throws -> Data {
        dataCalled = true
        return dataResult
    }
}
