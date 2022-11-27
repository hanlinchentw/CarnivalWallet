//
//  TransactionNotification.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/28.
//

import Foundation
import Combine

struct TransactionNotification {
	struct Success {
		static let name = "TRANSACTION_SUCCESS"
		static let notification = Notification.Name(name)
		static var publisher: NotificationCenter.Publisher {
			NotificationCenter.default.publisher(for: notification)
		}
		static func post() {
			NotificationCenter.default.post(name: notification, object: nil)
		}
	}
}
