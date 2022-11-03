//
//  FunctionModelItem.swift
//  IRHierarchyTreeTableView-swift
//
//  Created by Phil Chang on 2022/7/26.
//  Copyright © 2022 Yahoo. All rights reserved.
//

import Foundation
import UIKit

enum FunctionType {
    case branch
    case leaf
}

protocol FunctionModelItem {
    var hideCells: Bool { get set }
    var type: FunctionType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
    var sectionLeftIcon: UIImage { get }

    func rowTitle(for index: Int)
    func update(with device: Device)
}
