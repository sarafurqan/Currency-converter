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
    
    private let liveApiUrl: String = "convert"
    
    func convertCurrency(
        from: String,
        to: String,
        amount: String,
        success: @escaping (CurrencyConversionResponse?) -> Void,
        failure: @escaping (Error?) -> Void) {
        
        let params = "from=\(from)&to=\(to)&amount=\(amount)"
        
        if let url = URL.with(string: liveApiUrl, param: params) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            print(urlRequest)
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    do {
                        let live = try JSONDecoder().decode(CurrencyConversionResponse.self, from: data)
                        print(live)
                        success(live)
                    } catch let error {
                        print(error)
                        failure(error)
                    }
                }
            }.resume()
        }
    }
}
