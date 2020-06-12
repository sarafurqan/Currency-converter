//
//  LiveExchangeResponse.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/10.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import Foundation

struct LiveExchangeResponse: Codable {
    let terms, privacy: String?
    let timestamp: Int?
    let source: String?
    var quotes: [String: Double]
    let success: Bool
    let error: ErrorResponse?
}

// Mark :- Currency Quote

struct ExchangeRate: Codable {
    let currency: String
    let rate: Double
}
