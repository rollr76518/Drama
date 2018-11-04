//
//  DramaViewController.swift
//  Drama
//
//  Created by Ryan on 2018/11/3.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import UIKit

class DramaViewController: UIViewController {

	var drama: DramaModel!
	
	@IBOutlet var ratingLabel: UILabel!
	@IBOutlet var issueLabel: UILabel!
	@IBOutlet var totalViewsLabel: UILabel!
	@IBOutlet var thumbImageView: UIImageView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		setupUI()
    }

}

private extension DramaViewController {
	func setupUI() {
		title = drama.name
		let rating = String(format: "%.2f", drama.rating)
		ratingLabel.text = "評分：\(rating)"
		issueLabel.text = "出版日期：\(drama.createdAt.formatter("yyyy/MM/dd"))"
		totalViewsLabel.text = "觀看次數：\(drama.totalViews.thousandFormatter())"
		thumbImageView.imageFromURL(drama.thumbURL, placeholder: #imageLiteral(resourceName: "placeholder"))
	}
}
