//
//  LiveExchangeRequest.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/10.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import UIKit

struct LiveExchangeRequest {
    static let sharedInstance: LiveExchangeRequest = LiveExchangeRequest()
    
    private let liveApiUrl: String = "live"
    
    func getLiveExchange(
        success: @escaping (LiveExchangeResponse?) -> Void,
        failure: @escaping (Error?) -> Void) {
        
        if let url = URL.with(string: liveApiUrl) {
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            print(urlRequest)
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    do {
                        let live = try JSONDecoder().decode(LiveExchangeResponse.self, from: data)
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

extension URL {
    private static var baseUrl: String {
        return "http://api.currencylayer.com/"
    }
    
    private static var accessKey: String {
        return "format=1&access_key=ed77e0915315e85dfdb27ca2cf0bffaa"
    }
    
    static func with(string: String, param: String? = nil) -> URL? {
        var url = "\(baseUrl)\(string)?\(accessKey)"
        if let param = param {
            url += "&\(param)"
        }
        return URL(string: url)
    }
}
