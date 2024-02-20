import XCTest
@testable import EIDASpaceX

final class WebserviceTests: XCTestCase {
    
    var webservice: MockDataWebservice!

    override func setUpWithError() throws {
       
        webservice = MockDataWebservice()
    }

    func testCrewItemsRetrieval() async throws {
        
        // GIVEN a webservice with crew resources
        let url = Bundle(for: WebserviceTests.self).url(forResource: "crew", withExtension: "json")!
        let data = try Data(contentsOf: url)
        webservice.dataResult = data
        
        // WHEN we request a Crew resource
        
        let crew = try await webservice.retrieveCrew()
        
        // THEN we should retrieve all the crew resources
        XCTAssertEqual(crew.count, 30)
    }
    
    func testCrewItemsDecoding() async throws {
        
        // GIVEN a webservice with crew resources
        let url = Bundle(for: WebserviceTests.self).url(forResource: "crew", withExtension: "json")!
        let data = try Data(contentsOf: url)
        webservice.dataResult = data
        
        // WHEN we request a Crew resource
        
        let crew = try await webservice.retrieveCrew()
        
        // THEN the crew resources should be decoded correctly
        
        XCTAssertEqual(crew[0].id, "5ebf1a6e23a9a60006e03a7a")
        XCTAssertEqual(crew[0].name, "Robert Behnken")
        XCTAssertEqual(crew[0].image, "https://imgur.com/0smMgMH.png")
        
        XCTAssertEqual(crew[10].id, "5fe3c587b3467846b3242198")
        XCTAssertEqual(crew[10].name, "Raja Chari")
        XCTAssertEqual(crew[10].image, "https://imgur.com/uKj6DOF.png")
        
        XCTAssertEqual(crew[20].id, "61eefd5b9eb1064137a1bd7a")
        XCTAssertEqual(crew[20].name, "Mark Pathy")
        XCTAssertEqual(crew[20].image, "https://i.imgur.com/IFpgQpP.png")
    }
}
