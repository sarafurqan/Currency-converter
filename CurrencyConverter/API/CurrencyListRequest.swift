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
    
    private let liveApiUrl: String = "list"
    
    func getAllCurrencies(
        success: @escaping (CurrencyListResponse?) -> Void,
        failure: @escaping (Error?) -> Void) {
        
        if let url = URL.with(string: liveApiUrl) {
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            print(urlRequest)
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    do {
                        let live = try JSONDecoder().decode(CurrencyListResponse.self, from: data)
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
