//
//  Async_Await_Demo_Tests.swift
//  Async Await Demo Tests
//
//  Created by Trevor Whittingham on 9/22/22.
//

import XCTest
@testable import Async_Await_Demo

final class Async_Await_Demo_Tests: XCTestCase {

    func testPersonAPI() {
        let sut = StarWarsAPI()
        let exp = expectation(description: "wait for API response")
        sut.loadPeople { result in
            switch result {
            case .success(let personArray):
                print(personArray)
                XCTAssert(personArray.count > 0)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 30) // the API can be slow :]
    }
    
    func testPersonAPIAsync() async throws {
        let sut = StarWarsAPI()
        let personArray = try await sut.loadPeopleAsync()
        print(personArray)
        XCTAssert(personArray.count > 0)
    }

}
