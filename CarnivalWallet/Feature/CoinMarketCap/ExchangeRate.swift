//
//  ExchangeRate.swift
//  CarnivalWallet
//
//  Created by 陳翰霖 on 2022/12/3.
//

import Foundation

//{
//	"data": {
//		"1": {
//			"id": 1,
//			"name": "Bitcoin",
//			"symbol": "BTC",
//			"slug": "bitcoin",
//			"is_active": 1,
//			"is_fiat": 0,
//			"circulating_supply": 17199862,
//			"total_supply": 17199862,
//			"max_supply": 21000000,
//			"date_added": "2013-04-28T00:00:00.000Z",
//			"num_market_pairs": 331,
//			"cmc_rank": 1,
//			"last_updated": "2018-08-09T21:56:28.000Z",
//			"tags": [
//				"mineable"
//			],
//			"platform": null,
//			"self_reported_circulating_supply": null,
//			"self_reported_market_cap": null,
//			"quote": {
//				"USD": {
//					"price": 6602.60701122,
//					"volume_24h": 4314444687.5194,
//					"volume_change_24h": -0.152774,
//					"percent_change_1h": 0.988615,
//					"percent_change_24h": 4.37185,
//					"percent_change_7d": -12.1352,
//					"percent_change_30d": -12.1352,
//					"market_cap": 852164659250.2758,
//					"market_cap_dominance": 51,
//					"fully_diluted_market_cap": 952835089431.14,
//					"last_updated": "2018-08-09T21:56:28.000Z"
//				}
//			}
//		}
//	},
//	"status": {
//		"timestamp": "2022-11-25T07:53:21.536Z",
//		"error_code": 0,
//		"error_message": "",
//		"elapsed": 10,
//		"credit_count": 1
//	}
//}

struct ExchangeRate: Decodable {
	let quote: Quote
}

struct Quote: Decodable {
	let usd: usdQuote
	enum CodingKeys: String, CodingKey {
		case usd = "USD"
	}
}

struct usdQuote: Decodable {
	let price: Double
}
