//
//  URLParametersCreatorTests.swift
//  CookuPotsTests
//
//  Created by Kamil Chołyk on 28/04/2022.
//

import XCTest
@testable import CookuPots

final class URLParametersCreatorTests: XCTestCase {
    var sut: URLParametersCreator!
    
    override func setUpWithError() throws {
        sut = URLParametersCreator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testReturnsProperStringForOnePair() throws {
        let testParams = [
            "testKey": "testValue"
        ]
        let result = sut.parametersInURL(parameters: testParams)
        let expected = "?testKey=testValue"
        XCTAssertEqual(result, expected)
    }
    
    func testReturnsProperStringForMultiplePairs() throws {
        let testParams = [
            "testKey": "testValue",
            "testKey2": "testValue2",
            "testKey3": "testValue3"
        ]
        let result = sut.parametersInURL(parameters: testParams)
        let expected = "?testKey=testValue&testKey2=testValue2&testKey3=testValue3"
        XCTAssertEqual(result, expected)
    }
    
    func testReturnsProperStringForNoObjects() throws {
        let testParams: [String: String] = [:]
        let result = sut.parametersInURL(parameters: testParams)
        let expected = ""
        XCTAssertEqual(result, expected)
    }
    
}
