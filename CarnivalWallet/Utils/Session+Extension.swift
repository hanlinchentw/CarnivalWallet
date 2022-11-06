//
//  Session+Extension.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/11/6.
//

import Foundation
import APIKit

extension Session {
	static func `send`<Request: APIKit.Request>(_ request: Request) async throws -> Request.Response {
		return try await withCheckedThrowingContinuation { continuation in
			Session.send(
				request,
				handler: { result -> Void in
					continuation.resume(with: result)
				})
		}
	}
}
