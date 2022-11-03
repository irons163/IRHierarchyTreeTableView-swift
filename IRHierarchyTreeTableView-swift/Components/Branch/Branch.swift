//
//  Branch.swift
//  IRHierarchyTreeTableView-swift
//
//  Created by Phil Chang on 2022/6/11.
//  Copyright © 2022 Yahoo. All rights reserved.
//

import Foundation
import UIKit

class Branch: NSObject, Corp {
    var superNode: Corp?
    
    var device: Device?
    
    required init(with device: Device) {
        <#code#>
    }
    
    func add(corp: Corp) {
        <#code#>
    }
    
    func remove(corp: Corp) {
        guard let children = self.children else { return }
        if children.contains(where: <#T##(Corp) throws -> Bool#>) {
            <#code#>
        }
    }
    
    func getChildren() -> [Corp]? {
        return self.children
    }
    
    func click() {
        self.isOpened = !self.isOpened
    }
    
    func loopUpdate() {
        UIView.setAnimationsEnabled(false)
        self.tableView?.performBatchUpdates({

        })
        if self.superNode != nil {
            self.loopUpdate()
        }
        UIView.setAnimationsEnabled(true)
    }
    
    var isOpened: Bool = false
    var isNeedReload: Bool = false
    var tableView: BranchTableIView?

    private var children: [Corp]?
    private var model: Model?

    init(with tableView: BranchTableIView) {
        self.tableView = tableView
        self.tableView?.dataSource = model
        self.tableView?.delegate = self
    }
}

extension Branch: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        <#code#>
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        <#code#>
    }
}

extension Branch: HierarchyViewModelDelegate {
    func attach(with tableView: BranchTableIView, index: Int) {
        guard let branch = children?[index] as? Branch else { return }
        if branch.tableView != nil, branch.tableView != tableView {
            branch.isNeedReload = true
        }
        if (tableView.bindedBranch != nil), tableView.bindedBranch != branch {
            tableView.bindedBranch?.isNeedReload = true
        }
        tableView.bindedBranch = branch
        branch.tableView = tableView
        branch.tableView?.dataSource = branch.model
        branch.tableView?.delegate = branch
    }

    func reload(with index: Int) {
        <#code#>
    }

    func reload() {
        self.tableView?.reloadData {
            var needLoopUpdate = true
            self.children?.forEach({ (child) in
                if let child = child as? Branch, child.isOpened {
                    needLoopUpdate = false
                }
            })
            if needLoopUpdate {
                self.loopUpdate()
            }
        }
    }

    func hide(section: Int) {
        <#code#>
    }


}

extension Branch: DeviceDetailHeaderViewDelegate {
    func didClickAccessButtonInSection(section: Int) {
        
    }
}

//extension Branch: Equatable {
//    static func == (lhs: Branch, rhs: Branch) -> Bool {
//        <#code#>
//    }
//}
