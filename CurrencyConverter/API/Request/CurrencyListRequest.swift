//
//  CurrencyListRequest.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/11.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import UIKit

struct CurrencyListRequest {
    static let sharedInstance: CurrencyListRequest = CurrencyListRequest()
    
    private let apiUrl: String = "list"
    
    func getAllCurrencies(
        currencies: [String] = [],
        success: @escaping (CurrencyListResponse?) -> Void,
        failure: @escaping (ErrorResponse?) -> Void) {
        
        APIManager.sharedInstance.requestApi(
            apiUrl: apiUrl,
            params: "&currencies=\(currencies))",
            handler: {data, response, error in
                if let data = data {
                    do {
                        let response = try JSONDecoder()
                            .decode(CurrencyListResponse.self, from: data)
                        success(response)
                    } catch let error {
                        print(error)
                        failure(ErrorResponse(code: -1, info: "Something went wrong"))
                    }
                }
        })
    }
}
