//
//  DramaViewController.swift
//  Drama
//
//  Created by Ryan on 2018/11/3.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import UIKit

class DramaViewController: UIViewController {

	var drama: DramaModel? {
		didSet {
			if isViewLoaded {
				setupUI()
			}
		}
	}
	
	@IBOutlet var scrollView: UIScrollView!
	@IBOutlet var ratingLabel: UILabel!
	@IBOutlet var issueLabel: UILabel!
	@IBOutlet var totalViewsLabel: UILabel!
	@IBOutlet var thumbImageView: UIImageView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		setupUI()
    }

}

extension DramaViewController {
	func setupUI() {
		guard let drama = drama else { return }
		title = drama.name
		let rating = String(format: "%.2f", drama.rating)
		ratingLabel.text = "評分：\(rating)"
		issueLabel.text = "出版日期：\(drama.createdAt.formatter("yyyy/MM/dd"))"
		totalViewsLabel.text = "觀看次數：\(drama.totalViews.thousandFormatter())"
		thumbImageView.imageFromURL(drama.thumbURL, placeholder: #imageLiteral(resourceName: "placeholder"))
	}
}

extension DramaViewController {
	private static let kDramaId = "dramaId"
	private static let kScrollViewContentOffset = "scrollViewContentOffset"

	override func encodeRestorableState(with coder: NSCoder) {
		if let drama = drama {
			coder.encode(drama.id, forKey: DramaViewController.kDramaId)
		}
		
		coder.encode(scrollView.contentOffset, forKey: DramaViewController.kScrollViewContentOffset)

		super.encodeRestorableState(with: coder)
	}
	
	override func decodeRestorableState(with coder: NSCoder) {
		let dramaId = coder.decodeObject(forKey: DramaViewController.kDramaId) as! String
		if let drama = try? DataManager.loadLocalDrama(id: dramaId) {
			self.drama = drama
		}
		
		let contentOffset = coder.decodeCGPoint(forKey: DramaViewController.kScrollViewContentOffset)

		perform(#selector(setScrollViewContentOffset), with: contentOffset, afterDelay: 0.25)

		super.decodeRestorableState(with: coder)
	}
	
	override func applicationFinishedRestoringState() {
		super.applicationFinishedRestoringState()
	}
	
	@objc func setScrollViewContentOffset(_ contentOffset: CGPoint) {
		scrollView.contentOffset = contentOffset
	}
}
