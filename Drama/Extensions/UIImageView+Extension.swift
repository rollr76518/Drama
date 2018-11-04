//
//  UIImageView+Extension.swift
//  Drama
//
//  Created by Ryan on 2018/11/3.
//  Copyright © 2018年 Hanyu. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {
	func imageFromURL(_ url: URL, placeholder: UIImage?) {
		self.image = placeholder
		
		URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
			if let error = error {
				print(error)
				return
			}
			
			if let data = data {
				let image = UIImage(data: data)
				DispatchQueue.main.async {
					self.image = image
				}
			}
		}).resume()
	}
}
