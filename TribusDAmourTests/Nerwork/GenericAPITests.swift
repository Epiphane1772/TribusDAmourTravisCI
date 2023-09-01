//
//  GenericAPITests.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 5/27/23.
//

import XCTest
@testable import TribusDAmour

class GenericAPITests: XCTestCase {

    var genericAPI: GenericAPI!
    
    override func setUp() {
        super.setUp()
        genericAPI = GenericAPI()
    }

    override func tearDown() {
        genericAPI = nil
        super.tearDown()
    }

    func testGetData_SuccessfulResponse() {
        struct MockWeatherRequest: TribusDAmour.RequestProtocol {
            var host: String = "api.openweathermap.org"
            var path: String = "/data/2.5/weather"
            var method: String = "GET"
            var urlParams: [String: String]? = [
                "q": "Mountain View",
                "appid": "0a0623a52a2aba27ca9a5104e73948ce"
            ]
        }

        let expectation = XCTestExpectation(description: "Get data completion")

        guard let mockDataPath = Bundle(for: type(of: self)).path(forResource: "MockWeatherData", ofType: "txt") else {
            XCTFail("Mock data file not found")
            return
        }

        do {
            let mockData = try Data(contentsOf: URL(fileURLWithPath: mockDataPath))

            let mockURLSession = MockURLSession(data: mockData, response: nil, error: nil)
            genericAPI.urlSession = mockURLSession

            genericAPI.getData(request: MockWeatherRequest()) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        let weatherResult = DataMapper.map(data, to: WeatherResponse.self)
                        switch weatherResult {
                        case .success(let weatherResponse):
                            XCTAssertEqual(weatherResponse.name, "Mountain View")
                            XCTAssertEqual(weatherResponse.weather?.first?.main, "Clear")
                            XCTAssertEqual(weatherResponse.weather?.first?.description, "clear sky")
                            expectation.fulfill()
                        case .failure(let error):
                            XCTFail("Decoding error: \(error)")
                        }
                    } else {
                        XCTFail("No data received")
                    }
                case .failure(let error):
                    XCTFail("API error: \(error)")
                }
            }
        } catch {
            XCTFail("Failed to load mock data: \(error)")
        }

        wait(for: [expectation], timeout: 5.0)
    }
}

class MockURLSession: URLSession {
    var mockDataTask: MockURLSessionDataTask?
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    convenience init(data: Data?, response: URLResponse?, error: Error?) {
        self.init()
        self.mockData = data
        self.mockResponse = response
        self.mockError = error
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let mockDataTask = MockURLSessionDataTask()
        mockDataTask.completionHandler = { [weak self] in
            completionHandler(self?.mockData, self?.mockResponse, self?.mockError)
        }
        self.mockDataTask = mockDataTask
        return mockDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    var completionHandler: (() -> Void)?

    override func resume() {
        completionHandler?()
    }
}

struct WeatherResponse: Decodable {
    let name: String
    let weather: [Weather]?

    struct Weather: Decodable {
        let main: String
        let description: String
    }
}
