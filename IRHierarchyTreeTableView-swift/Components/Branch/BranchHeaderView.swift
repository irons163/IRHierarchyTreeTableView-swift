//
//  BranchHeaderView.swift
//  IRHierarchyTreeTableView-swift
//
//  Created by Phil Chang on 2022/6/11.
//  Copyright © 2022 Yahoo. All rights reserved.
//

import Foundation
import UIKit

protocol DeviceDetailHeaderViewDelegate: AnyObject {
    func didClickAccessButtonInSection(section: Int)
}

class BranchHeaderView: UITableViewHeaderFooterView {

    @IBOutlet var leftIcon: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var arrowImageView: UIImageView!
    weak var delegate: DeviceDetailHeaderViewDelegate?

    @IBAction func didClickHeaderView(_ sender: UIView) {
        self.delegate?.didClickAccessButtonInSection(section: sender.tag)
    }
}
