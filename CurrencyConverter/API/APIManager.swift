//
//  APIConfig.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/10.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import Foundation
import UIKit

enum HttpMethod: String {
    case post = "POST"
    case get  = "GET"
}

class APIManager: NSObject {
    
    static let sharedInstance: APIManager = APIManager()
    
    private override init() {}
    
    public func requestApi(httpMethod: String = HttpMethod.get.rawValue, apiUrl: String, params: String?, handler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        
        if let url = URL.with(string: apiUrl, param: params) {
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = httpMethod
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let HTTPHeaderField_ContentType  = "Content-Type"
            let ContentType_ApplicationJson  = "application/json"
            urlRequest.timeoutInterval = 60.0
            urlRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
            urlRequest.addValue(ContentType_ApplicationJson, forHTTPHeaderField: HTTPHeaderField_ContentType)
            
            print(urlRequest)
            
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                handler(data, response, error as? Error)
            }
            dataTask.resume()
        }
    }
}

