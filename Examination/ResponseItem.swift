//
//  Response.swift
//  Examination
//
//  Created by yongfaliu on 2021/1/31.
//

import Foundation

struct ResponseItem {
    let timestamp: TimeInterval
    let content: String?
    private let timestampKey = "timestampKey"
    private let contentKey = "contentKey"

    var plistDict: [String:Any] {
        var dict = [String:Any]()
        dict[timestampKey] = timestamp
        dict[contentKey] = content

        return dict
    }
    init(timestamp: Double, content: String? = nil) {
        self.timestamp = timestamp
        self.content = content
    }
    init?(dict: [String:Any]) {
        guard let timestamp = dict[timestampKey] as? TimeInterval else { return nil }
        self.timestamp = timestamp
        if let content = dict[contentKey] as? String {
            self.content = content
        } else {
            self.content = nil
        }
    }
}
