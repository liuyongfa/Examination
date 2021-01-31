//
//  DetailViewController.swift
//  Examination
//
//  Created by yongfaliu on 2021/2/1.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var itemInfo: ResponseItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(itemInfo!.timestamp * 1000)"
        self.textView.text = itemInfo?.content
    }
}

