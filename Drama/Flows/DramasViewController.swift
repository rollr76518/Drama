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
	
	let kTableViewCellHeight: CGFloat = 120.0
	
	fileprivate var rawDramas = [DramaModel]() {
		didSet {
			DispatchQueue.main.async {
				let filterString = self.searchBar.text ?? ""
				self.updateFilterDramas(with: filterString)
			}
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
		
		loadData()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
			tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
		}
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
					let alert = UIAlertController(title: "錯誤", message: error.localizedDescription)
					self.present(alert, animated: true, completion: nil)
				}
			}
		}
	}
	
	func updateFilterDramas(with searchText: String) {
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
		return kTableViewCellHeight
	}
}

extension DramasViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		updateFilterDramas(with: searchText)
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

extension DramasViewController {
	private static let kTableViewContentOffset = "tableViewContentOffset"
	private static let kSearchBarIsFirstResponder = "searchBarIsFirstResponder"
	private static let kSearchBarText = "searchBarText"
	
	override func encodeRestorableState(with coder: NSCoder) {
		coder.encode(tableView.contentOffset, forKey: DramasViewController.kTableViewContentOffset)
		coder.encode(searchBar.isFirstResponder, forKey: DramasViewController.kSearchBarIsFirstResponder)
		coder.encode(searchBar.text, forKey: DramasViewController.kSearchBarText)
		
		super.encodeRestorableState(with: coder)
	}
	
	override func decodeRestorableState(with coder: NSCoder) {
		tableView.contentOffset = coder.decodeCGPoint(forKey: DramasViewController.kTableViewContentOffset)
		
		if coder.decodeBool(forKey: DramasViewController.kSearchBarIsFirstResponder) {
			searchBar.becomeFirstResponder()
		}

		let searchText = coder.decodeObject(forKey: DramasViewController.kSearchBarText) as! String
		searchBar.text = searchText
		
		super.decodeRestorableState(with: coder)
	}
	
	override func applicationFinishedRestoringState() {
		super.applicationFinishedRestoringState()
	}
}
