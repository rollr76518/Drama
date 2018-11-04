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
			tableView.keyboardDismissMode = .onDrag
		}
	}
	@IBOutlet var searchBar: UISearchBar!
	
	fileprivate var rawDramas = [DramaModel]() {
		didSet {
			filteredDramas = rawDramas
		}
	}
	fileprivate var filteredDramas = [DramaModel]() {
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

		title = "戲劇列表"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		loadData()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? DramaViewController,
			let drama = sender as? DramaModel {
			vc.drama = drama
		}
    }

	// MARK: - IBActions
	@IBAction func viewDidTap(_ sender: UITapGestureRecognizer) {
		searchBar.resignFirstResponder()
	}
}

private extension DramasViewController {
	func loadData() {
		DataManager.dramas { [weak self] (status) in
			if let `self` = self {
				switch status {
				case .success(let dramas):
					self.rawDramas = dramas
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
		}
	}
}

extension DramasViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredDramas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: BriefTableViewCell.identifier, for: indexPath) as! BriefTableViewCell
		
		let drama = filteredDramas[indexPath.row]
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
		let drama = filteredDramas[indexPath.row]
		
		performSegue(withIdentifier: DramaViewController.identifier, sender: drama)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 120.0
	}
}

extension DramasViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText != "" {
			filteredDramas = rawDramas.filter({ (drama) -> Bool in
				let lowcaseSearchText = searchText.lowercased()
				let lowcaseName = drama.name.lowercased()
				return lowcaseName.contains(lowcaseSearchText)
			})
		} else {
			filteredDramas = rawDramas
		}
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
}

extension DramasViewController: UIGestureRecognizerDelegate {
	func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		return searchBar.isFirstResponder
	}
}
