//
//  TransactionViewController.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/21.
//

import UIKit

class TransactionViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(self.dismiss(animated:completion:)))
		barButtonItem.tintColor = .white
		self.navigationItem.leftBarButtonItem = barButtonItem
		self.navigationItem.title = "Transaction"
		self.navigationController?.navigationBar.backgroundColor = .black
		self.navigationController?.navigationBar.barTintColor = .white
		view.backgroundColor = .white
	}
}
