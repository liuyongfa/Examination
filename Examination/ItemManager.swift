//
//  ItemManager.swift
//  Examination
//
//  Created by yongfaliu on 2021/1/31.
//

import Foundation
import UIKit

class ItemManager: NSObject {
    private let perCount = 50
    private var responseItems: [ResponseItem] = []
    private var firstResponseItems: [ResponseItem] = []
    private(set) var timestampStrings: [TimeInterval] = []
    private(set) var isEnd = false

    private var currentPage = 0
    private(set) var fileUrl: URL = {
        let cachesUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return cachesUrl.appendingPathComponent(Bundle.main.infoDictionary!["CFBundleExecutable"]! as! String)
    }()
    let suffixeString = ".plist"
    private var catalogueFileUrl: URL {
        return fileUrl.appendingPathComponent("catalogue\(suffixeString)")
    }
    var itemCount: Int {
        return responseItems.count
    }
    var pageCount: Int {
        return timestampStrings.count
    }
//    private var loadName: String {
//        return
//    }
    override init() {
        super.init()
        print(fileUrl.path)
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: UIApplication.willResignActiveNotification, object: nil)
    }
    deinit {
      NotificationCenter.default.removeObserver(self)
      save()
    }
    func add(_ item: ResponseItem) {
        firstResponseItems.insert(item, at: 0)
        responseItems.insert(item, at: 0)
        NotificationCenter.default.post(name: NSNotification.Name("ItemAddNotification"), object: self, userInfo: nil)
        if 1 == itemCount % perCount {
            timestampStrings.insert(item.timestamp, at: 0)
            saveTimestampStrings()
        }
        saveItem(items: firstResponseItems, name: "\(firstResponseItems.last!.timestamp)")

        if perCount == firstResponseItems.count {
            firstResponseItems.removeAll()
        }
    }
    
    func item(at index: Int) -> ResponseItem {
        return responseItems[index]
    }
    func lastItem() -> ResponseItem? {
        return responseItems.last
    }
    func removeAll() {
        do {
            try FileManager.default.removeItem(at: fileUrl)
            responseItems.removeAll()
            timestampStrings.removeAll()
            firstResponseItems.removeAll()
        } catch {
            print(error)
        }
 
    }
    private func saveTimestampStrings() {
        let array = timestampStrings as NSArray
        if !array.write(to: catalogueFileUrl, atomically: true) {
            print("Could not timestampStrings")
        }
    }
    private func saveItem(items: [ResponseItem], name: String) {
        let nsItems = items.map { $0.plistDict }

        do {
            let plistData = try PropertyListSerialization.data(
              fromPropertyList: nsItems,
              format: PropertyListSerialization.PropertyListFormat.xml,
              options: PropertyListSerialization.WriteOptions(0)
            )
            try plistData.write(to: fileUrl.appendingPathComponent("\(name + suffixeString)"), options: Data.WritingOptions.atomic)
        } catch {
            print(error)
        }
    }
    @objc private func save() {
        saveTimestampStrings()
        saveItem(items: firstResponseItems, name: "\(firstResponseItems.last!.timestamp)")
        firstResponseItems.removeAll()
    }
    func loadItem() {
        if !FileManager.default.fileExists(atPath: fileUrl.path) {
            do {
                try FileManager.default.createDirectory(at: fileUrl, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }
        if 0 == timestampStrings.count {
            if let itemArray = NSArray(contentsOf: catalogueFileUrl) as? [TimeInterval] {
                timestampStrings = itemArray
            }
        }
        if currentPage >= timestampStrings.count {
            isEnd = true
            return
        }
        guard timestampStrings.count > 0 else {
            return
        }
        if let nsItems = NSArray(contentsOf: fileUrl.appendingPathComponent("\(timestampStrings[currentPage])\( suffixeString)")) {
            currentPage += 1
          for dict in nsItems {
            if let item = ResponseItem(dict: dict as! [String:Any]) {
                responseItems.append(item)
            }
          }
        }
        NotificationCenter.default.post(name: NSNotification.Name("ItemAddNotification"), object: self, userInfo: nil)

        if 1 >= currentPage && itemCount < perCount {
            firstResponseItems = responseItems
        }
    }
}
