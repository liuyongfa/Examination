//
//  ItemCell.swift
//  Examination
//
//  Created by yongfaliu on 2021/2/1.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(with item: ResponseItem) {
        titleLabel.text = "\(item.timestamp * 1000)"
    }
}
