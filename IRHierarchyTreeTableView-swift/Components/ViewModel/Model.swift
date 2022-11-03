//
//  Model.swift
//  IRHierarchyTreeTableView-swift
//
//  Created by Phil Chang on 2022/7/26.
//  Copyright © 2022 Yahoo. All rights reserved.
//

import UIKit

protocol HierarchyViewModelDelegate: AnyObject {
    func attach(with tableView: BranchTableIView, index: Int)
    func reload(with index: Int)
    func reload()
    func hide(section: Int)
}

class Model: NSObject {
    var items: [FunctionModelItem] = []
    var infoTitleItems: [AnyObject]?
    var device: Device?

    weak var delegate: HierarchyViewModelDelegate?
    weak var tableView: UITableView?

    func getSectionTitle(at section: Int) -> String {
        return items[section].sectionTitle
    }

    func getSectionLeftIcon(at section: Int) -> UIImage {
        return items[section].sectionLeftIcon
    }

    func getFunctionType(at section: Int) -> FunctionType {
        return items[section].type
    }

    func hideRows(_ hide: Bool, at section: Int) {
        items[section].hideCells = hide
    }

    func isHiddenRows(at section: Int) -> Bool {
        return items[section].hideCells
    }

    func addItem(_ item: FunctionModelItem) {
        self.items.append(item)
    }

    func hideAll(for tableView: UITableView) {
        for section in items.indices {
            let shouldHiddenRows = !self.isHiddenRows(at: section)
            self.hideRows(shouldHiddenRows, at: section)
            if shouldHiddenRows {
                tableView.deleteRows(at: [IndexPath(row: 0, section: section)], with: .none)
            } else {
                tableView.insertRows(at: [IndexPath(row: 0, section: section)], with: .none)
            }
        }
    }

    func loadAll(for tableView: UITableView) {
        for section in 0..<tableView.numberOfSections {
            tableView.deleteSections(IndexSet(integer: section), with: .none)
            tableView.deleteRows(at: [IndexPath(row: 0, section: section)], with: .none)
        }
        for section in items.indices {
            tableView.insertSections(IndexSet(integer: section), with: .none)
            tableView.insertRows(at: [IndexPath(row: 0, section: section)], with: .none)
        }
    }
}

extension Model: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .branch:
            let cell = tableView.dequeueReusableCell(withIdentifier: BranchTableViewCell.identifier, for: indexPath)
            cell.accessoryType = .none
            cell.selectionStyle = .none
            return cell
        case .leaf:
            let cell = tableView.dequeueReusableCell(withIdentifier: BranchTableViewCell.identifier, for: indexPath)
            cell.accessoryType = .none
            cell.selectionStyle = .none
            return cell
        }
    }
}
