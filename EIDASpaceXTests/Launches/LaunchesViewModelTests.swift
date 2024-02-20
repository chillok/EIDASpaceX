import XCTest
@testable import EIDASpaceX

final class LaunchesViewModelTests: XCTestCase {
    
    var webservice: MockWebservice!
    var storage: MockStorage!
    var router: MockRouter!
    var viewModel: (any LaunchesViewModelProtocol)!

    override func setUpWithError() throws {
        webservice = MockWebservice()
        storage = MockStorage()
        router = MockRouter()
    }

    func testLaunchesRetrievalCalled() throws {
        
        // GIVEN a launches view model with blank state
        viewModel = LaunchesViewModel(webservice: webservice,
                                      storage: storage,
                                      router: router)
        
        // WHEN we request the launches from the view model
        viewModel.retrieveLaunches()
        
        eventually {
            // THEN the webservice should attempt to retrieve them
            XCTAssertTrue(self.webservice.retrieveLaunchesCalled)
        }
        
    }
    
    func testLaunchesStorageCalled() throws {
        
        // GIVEN a launches view model with blank state
        viewModel = LaunchesViewModel(webservice: webservice,
                                      storage: storage,
                                      router: router)
        
        // WHEN we request the launches from the view model
        viewModel.retrieveLaunches()
        
        eventually {
            
            // THEN the storage should attempt to store them
            XCTAssertTrue(self.storage.storeCalled)
        }
        
    }
    
    func testLaunchesStorageRetrievealCalled() throws {
        
        // GIVEN a launches view model with blank state
        viewModel = LaunchesViewModel(webservice: webservice,
                                      storage: storage,
                                      router: router)
        
        // WHEN we request the launches from the view model
        viewModel.retrieveLaunches()
        
        eventually {
            
            // THEN the storage should attempt to retrieve them
            XCTAssertTrue(self.storage.retrieveAllCalled)
        }
        
    }
    
    func testLaunchesShowDetailCalled() throws {
        
        // GIVEN a launches view model with blank state
        viewModel = LaunchesViewModel(webservice: webservice,
                                      storage: storage,
                                      router: router)
        
        // WHEN we request the launches from the view model
        _ = viewModel.selectLaunch(from: .init(id: "", flightNumber: 2, name: ""))
        
        eventually {
            
            // THEN the router should attempt to show the launch details
            XCTAssertTrue(self.router.showDetailCalled)
        }
    }
    
    func testLaunchesRetrievalFailure() {
        
        // GIVEN a launches view model with blank state, but the webservice is down
        viewModel = LaunchesViewModel(webservice: MockFailingWebservice(),
                                      storage: storage,
                                      router: router)
        
        // WHEN we request the launches from the view model
        viewModel.retrieveLaunches()
        
        eventually {
            // THEN the webservice fail and our viewModel will update state
            guard case .failed = self.viewModel.launches else {
                XCTFail()
                return
            }
        }
    }
}
