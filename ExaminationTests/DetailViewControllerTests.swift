//
//  DetailViewControllerTests.swift
//  ExaminationTests
//
//  Created by yongfaliu on 2021/2/1.
//

import XCTest
@testable import Examination

class DetailViewControllerTests: XCTestCase {
    var sut: DetailViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        sut = storyboard
          .instantiateViewController(
            withIdentifier: "DetailViewController")
          as? DetailViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


}
