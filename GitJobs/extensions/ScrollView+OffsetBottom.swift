//
//  ScrollView+OffsetBottom.swift
//  GitJobs
//
//  Created by Rustam on 04.04.2021.
//

import UIKit

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat) -> Bool {
        self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
