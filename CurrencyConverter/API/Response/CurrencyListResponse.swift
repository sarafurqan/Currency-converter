//
//  CurrencyListResponse.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/11.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import Foundation

struct CurrencyListResponse: Codable {
    let currencies: [String: String]?
    let success: Bool
    let error: ErrorResponse?
}

// Mark :- Country Currency

struct CountryCurrency: Codable {
    let code: String
    let name: String
}
