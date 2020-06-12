//
//  CurrencyConversionResponse.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/11.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import Foundation

struct CurrencyConversionResponse: Codable {
    let result: Double?
    let success: Bool
    let error: ErrorResponse?
}
