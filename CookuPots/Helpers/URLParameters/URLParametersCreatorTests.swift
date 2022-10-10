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
        let testParams: [URLParameter] = [
            .init(key: "testKey", value: "testValue")
        ]
        let result = sut.parametersInURL(parameters: testParams)
        let expected = "?testKey=testValue"
        XCTAssertEqual(result, expected)
    }
    
    func testReturnsProperStringForMultiplePairs() throws {
        let testParams: [URLParameter] = [
            .init(key: "testKey", value: "testValue"),
            .init(key: "testKey2", value: "testValue2"),
            .init(key: "testKey3", value: "testValue3")
        ]
        let result = sut.parametersInURL(parameters: testParams)
        let expected = "?testKey=testValue&testKey2=testValue2&testKey3=testValue3"
        XCTAssertEqual(result, expected)
    }
    
    func testReturnsProperStringForNoObjects() throws {
        let testParams: [URLParameter] = []
        let result = sut.parametersInURL(parameters: testParams)
        let expected = ""
        XCTAssertEqual(result, expected)
    }
    
}
