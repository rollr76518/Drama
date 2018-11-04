//
//  Cell+Extension.swift
//  Drama
//
//  Created by Ryan on 2018/11/4.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import UIKit.UITableView
import UIKit.UICollectionView

extension UITableViewCell {
	class var nib: UINib {
		return UINib(nibName: identifier, bundle: nil)
	}
}

extension UITableViewHeaderFooterView {
	class var nib: UINib {
		return UINib(nibName: identifier, bundle: nil)
	}
}

extension UICollectionReusableView {
	class var nib: UINib {
		return UINib(nibName: identifier, bundle: nil)
	}
}
