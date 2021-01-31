//
//  ItemListDataProvider.swift
//  Examination
//
//  Created by yongfaliu on 2021/2/1.
//

import UIKit

class ItemListDataProvider: NSObject {
    var itemManager: ItemManager?
}

extension ItemListDataProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return itemManager?.itemCount ?? 0
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "ItemCell",
        for: indexPath) as! ItemCell
      
      guard let itemManager = itemManager else { fatalError() }
 
      let  item = itemManager.item(at: indexPath.row)

      cell.configCell(with: item)
      
      return cell
    }
}
extension ItemListDataProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(
          name: NSNotification.Name("ItemSelectedNotification"),
          object: self,
          userInfo: ["index": indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        itemManager?.loadItem()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return itemManager?.isEnd ?? false ? 0 : 28

    }
}
@objc protocol ItemManagerSettable {
  var itemManager: ItemManager? { get set }
}
