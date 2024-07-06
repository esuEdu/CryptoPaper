import XCTest
import Combine
@testable import CryptoPaperNetwork

final class CryptoPaperNetworkTests: XCTestCase {
    var networkManager: NetworkManager!
    var mockSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        networkManager = NetworkManager(session: mockSession)
    }
    
    override func tearDown() {
        networkManager = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testSendRequestAsyncSuccess() async throws {
        let mockData = """
        {
            "id": 1,
            "message": "Success"
        }
        """.data(using: .utf8)
        
        mockSession.nextData = mockData
        mockSession.nextResponse = HTTPURLResponse(url: URL(string: "https://api.example.com/test")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let endpoint = MockEndpoint()
        let response: MockResponse? = try await networkManager.sendRequest(endpoint: endpoint)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.id, 1)
        XCTAssertEqual(response?.message, "Success")
    }
    
    func testSendRequestAsyncFailure() async throws {
        mockSession.nextError = NetworkError.requestFailed
        
        let endpoint = MockEndpoint()
        
        do {
            let _: MockResponse? = try await networkManager.sendRequest(endpoint: endpoint)
            XCTFail("Expected to throw, but it did not.")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.requestFailed)
        }
    }
}
