//
//  ItemManagerTest.swift
//  ExaminationTests
//
//  Created by yongfaliu on 2021/1/31.
//

import XCTest

@testable import Examination

class ItemManagerTest: XCTestCase {
    
    var sut: ItemManager!

    override func setUpWithError() throws {
        sut = ItemManager()
        
        if sut.itemCount > 0 {
            return
        }
        for _ in 0...110 {
            let item = ResponseItem(timestamp: Double(NSDate().timeIntervalSince1970))
            sut.add(item)
        }
    }

    override func tearDownWithError() throws {
//        sut.removeAll()
        sut = nil
    }

    func test_ItemAt_ReturnsAddedItem() {
        let item = ResponseItem(timestamp: 0.1)
        sut.add(item)
        
        let returnedItem = sut.item(at: 0)
        
        XCTAssertEqual(returnedItem.timestamp, item.timestamp)
    }
    
//    func test_RemoveAll_ResultsInCountsBeZero() {
//
//        sut.add(ResponseItem(timestamp: 0.1))
//        sut.add(ResponseItem(timestamp: 0.2))
//
//        XCTAssertEqual(sut.itemCount, 2)
//
//        sut.removeAll()
//
//        XCTAssertEqual(sut.itemCount, 0)
//    }
    func test_ItemAt_timestampStrings() {
        sut.loadItem()
        XCTAssertTrue(FileManager.default.fileExists(atPath: sut.fileUrl.path))


//        XCTAssertEqual(sut.pageCount, 3)
//        XCTAssertEqual(sut.timestampStrings.last, (sut.lastItem()!.timestamp))
//        sut.removeAll()
//        XCTAssertTrue(!FileManager.default.fileExists(atPath: sut.fileUrl.path))
    }

    
//    func test_Init_SetsTimestamp() {
//
//      let item = ToDoItem(title: "",
//                          timestamp: 0.0)
//
//      XCTAssertEqual(item.timestamp, 0.0)
//    }
//
}
