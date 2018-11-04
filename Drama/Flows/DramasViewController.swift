//
//  DramasViewController.swift
//  Drama
//
//  Created by Ryan on 2018/11/3.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import UIKit

class DramasViewController: UIViewController {

	@IBOutlet var tableView: UITableView! {
		didSet {
			tableView.register(BriefTableViewCell.nib, forCellReuseIdentifier: BriefTableViewCell.identifier)
			tableView.tableFooterView = UIView(frame: CGRect.zero)
		}
	}
	
	fileprivate var dramas = [DramaModel]() {
		didSet {
			if isViewLoaded {
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		loadData()
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? DramaViewController,
			let drama = sender as? DramaModel {
			vc.drama = drama
		}
    }

}

private extension DramasViewController {
	func loadData() {
		DataManager.dramas { [weak self] (status) in
			if let `self` = self {
				switch status {
				case .success(let dramas):
					self.dramas = dramas
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}
}

extension DramasViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dramas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: BriefTableViewCell.identifier, for: indexPath) as! BriefTableViewCell
		
		let drama = dramas[indexPath.row]
		cell.primaryLabel.text = drama.name

		let rating = String(format: "%.2f", drama.rating)
		let issueAt = drama.createdAt.formatter("yyyy/MM/dd")
		cell.secondaryLabel.text = "評分:\(rating) 出版日期:\(issueAt)"

		let thumbURL = drama.thumbURL
		cell.leftImageView.imageFromURL(thumbURL, placeholder: #imageLiteral(resourceName: "placeholder"))
		
		return cell
	}
}


extension DramasViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let drama = dramas[indexPath.row]
		
		performSegue(withIdentifier: DramaViewController.identifier, sender: drama)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 120.0
	}
}
