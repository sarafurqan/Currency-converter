//
//  ErrorResponse.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/12.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    let code: Int
    let info: String
}
