//
//  ResponseItemTest.swift
//  ExaminationTests
//
//  Created by yongfaliu on 2021/1/31.
//

import XCTest
@testable import Examination
class ResponseItemTest: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {

    }
    
    func test_Init_SetsTimestamp() {
        let item = ResponseItem(timestamp: 0.0)
      
        XCTAssertEqual(item.timestamp, 0.0)
    }
    
    func test_Init_SetsContent() {
        let content = "content"
        let item = ResponseItem(timestamp: 0.0, content: content)
      
      XCTAssertEqual(item.content, content)
    }


}
