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
    
    private let apiUrl: String = "live"
    
    func getLiveExchange(
        success: @escaping (LiveExchangeResponse?) -> Void,
        failure: @escaping (ErrorResponse?) -> Void) {
        
        APIManager.sharedInstance.requestApi(
            apiUrl: apiUrl,
            params: nil,
            handler: {data, response, error in
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(LiveExchangeResponse.self, from: data)
                        success(response)
                    } catch let error {
                        print(error)
                        failure(ErrorResponse(code: -1, info: "Something went wrong"))
                    }
                }
        })
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
