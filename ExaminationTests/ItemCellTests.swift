//
//  ItemCellTests.swift
//  ExaminationTests
//
//  Created by yongfaliu on 2021/2/1.
//

import XCTest

@testable import Examination

class ItemCellTests: XCTestCase {
    var tableView: UITableView!
    let dataSource = FakeDataSource()
    var cell: ItemCell!
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard
          .instantiateViewController(
            withIdentifier: "ItemListViewController")
          as! ItemListViewController
        
        
        controller.loadViewIfNeeded()
        
        
        tableView = controller.tableView
        tableView?.dataSource = dataSource
        
        
        cell = tableView?.dequeueReusableCell(
          withIdentifier: "ItemCell",
          for: IndexPath(row: 0, section: 0)) as? ItemCell
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func test_HasNameLabel() {
      XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    func test_ConfigCell_SetsTitle() {
        let item = ResponseItem(timestamp: Double(NSDate().timeIntervalSince1970))
      cell.configCell(with: item)
      
        XCTAssertEqual(cell.titleLabel.text, "\(item.timestamp * 1000)")
    }

}
extension ItemCellTests {
  class FakeDataSource: NSObject, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
      
      return 1
    }
    
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
      -> UITableViewCell {
        
        return UITableViewCell()
    }
  }
}
