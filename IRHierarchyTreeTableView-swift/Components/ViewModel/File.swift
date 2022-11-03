//
//  File.swift
//  IRHierarchyTreeTableView-swift
//
//  Created by Phil Chang on 2022/7/26.
//  Copyright © 2022 Yahoo. All rights reserved.
//

import Foundation

protocol Corp {
    var superNode: Corp? { get set }
    var device: Device? { get set }
    init(with device: Device)
    func add(corp: Corp)
    func remove(corp: Corp)
    func getChildren() -> [Corp]?
    func click()
    func loopUpdate()
    func loopUpdate(with calledChild: Corp)
}
