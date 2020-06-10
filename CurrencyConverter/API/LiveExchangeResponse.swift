//
//  LiveExchangeResponse.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/10.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import Foundation

// MARK: - Live

struct LiveExchangeResponse: Codable {
    let success: Bool?
    let terms, privacy: String?
    let timestamp: Int?
    let source: String?
    let quotes: [String: Double]?
}

struct CurrencyConversionResponse: Codable {
    
}

struct CurrencyListResponse: Codable {
    
}
