//
//  BranchTableIView.swift
//  IRHierarchyTreeTableView-swift
//
//  Created by Phil Chang on 2022/6/11.
//  Copyright © 2022 Yahoo. All rights reserved.
//

import UIKit

class BranchTableIView: UITableView {

    var bindedBranch: Branch?
    var reloadDataCompletionBlock: (() -> Void)?
    private lazy var tableHeightConstraint: NSLayoutConstraint = {
        let constraint = self.heightAnchor.constraint(equalToConstant: 44)
        constraint.isActive = true
        return constraint
    }()

    init() {
        super.init(frame: .zero, style: .plain)
        self.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if self.reloadDataCompletionBlock != nil {
            self.reloadDataCompletionBlock?()
            self.reloadDataCompletionBlock = nil
        }
    }

    override var contentSize: CGSize {
        get {
            return super.contentSize
        }
        set {
            super.contentSize = newValue
            self.superview?.layoutIfNeeded()
            self.updateTableHeight()
            self.superview?.layoutIfNeeded()
            self.invalidateIntrinsicContentSize()
        }
    }

    func reloadData(completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            print("reload completed")
            self.updateTableHeight()
            completion?()
        }
        print("reloading")
        super.reloadData()
        CATransaction.commit()
    }
    
    func updateTableHeight() {
        self.tableHeightConstraint.constant = self.contentSize.height
    }
}

extension BranchTableIView {
    func setup() {
        self.register(UINib(nibName: BranchTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BranchTableViewCell.identifier)
//        self.register(UINib(nibName: LeafTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: LeafTableViewCell.identifier)
        self.register(UINib(nibName: "BranchHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "BranchHeaderView")
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = UITableView.automaticDimension
        self.sectionHeaderHeight = CGFloat.leastNormalMagnitude
        self.estimatedSectionHeaderHeight = UITableView.automaticDimension
    }
}
