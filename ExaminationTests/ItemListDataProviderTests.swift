//
//  ItemListDataProviderTests.swift
//  ExaminationTests
//
//  Created by yongfaliu on 2021/2/1.
//

import XCTest
@testable import Examination

class ItemListDataProviderTests: XCTestCase {
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    var controller: ItemListViewController!
    override func setUpWithError() throws {
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(
          withIdentifier: "ItemListViewController") as? ItemListViewController
        
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
    }

    override func tearDownWithError() throws {
        sut.itemManager?.removeAll()
    }
    func test_NumberOfRows_Section1_IsItemCount() {
      sut.itemManager?.add(ResponseItem(timestamp: Double(NSDate().timeIntervalSince1970)))
      
      XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
      
      sut.itemManager?.add(ResponseItem(timestamp: Double(NSDate().timeIntervalSince1970)))
      
      tableView.reloadData()
      
      XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
}
