//
//  CurrencyConversionRequest.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/11.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import UIKit

struct CurrencyConversionRequest {
    static let sharedInstance: CurrencyConversionRequest = CurrencyConversionRequest()
    
    private let apiUrl: String = "convert"
    
    func convertCurrency(
        from: String,
        to: String,
        amount: String,
        success: @escaping (CurrencyConversionResponse?) -> Void,
        failure: @escaping (ErrorResponse?) -> Void) {
        
        let params = "from=\(from)&to=\(to)&amount=\(amount)"
        
        APIManager.sharedInstance.requestApi(
            apiUrl: apiUrl,
            params: params,
            handler: {data, response, error in
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(CurrencyConversionResponse.self, from: data)
                        success(response)
                    } catch let error {
                        print(error)
                        failure(ErrorResponse(code: -1, info: "Something went wrong"))
                    }
                }
        })
    }
}
