//
//  ItemListViewController.swift
//  Examination
//
//  Created by yongfaliu on 2021/2/1.
//

import UIKit
import Alamofire

class ItemListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var dataProvider: ItemListDataProvider = ItemListDataProvider()
    let itemManager = ItemManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        requestFunc()
        dataProvider.itemManager = itemManager
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(showDetails(sender:)),
          name: NSNotification.Name("ItemSelectedNotification"),
          object: nil)
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(reloadItemData(sender:)),
          name: NSNotification.Name("ItemAddNotification"),
          object: nil)
    }
    @objc func reloadItemData(sender: NSNotification) {
        tableView.reloadData()
    }
    
    @objc func showDetails(sender: NSNotification) {
      guard let index = sender.userInfo?["index"] as? Int else
      { fatalError() }
      
      
      if let nextViewController = storyboard?.instantiateViewController(
        withIdentifier: "DetailViewController") as? DetailViewController {
        
        
        nextViewController.itemInfo = itemManager.item(at: index)
        navigationController?.pushViewController(nextViewController,
                                                 animated: true)
      }
    }
}

extension ItemListViewController {
    private func requestFunc() {
        Timer.scheduledTimer(withTimeInterval: TimeInterval(5), repeats: true, block:{(timer: Timer) -> Void in
            AF.request("https://api.github.com/").responseString { (response) in
                guard let result = response.value else {
                    return
                }
                self.itemManager.add(ResponseItem(timestamp: Double(NSDate().timeIntervalSince1970), content: result))
            }
        })
    }
}
