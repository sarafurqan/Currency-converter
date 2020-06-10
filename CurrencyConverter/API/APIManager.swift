//
//  APIConfig.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/10.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import Foundation
import UIKit

struct RequestType {
    static let  POST = "POST"
    static let  GET = "GET"
}

enum HttpType: String {
    case POST = "POST"
    case GET  = "GET"
}

class APIManager: NSObject {
    
    static let sharedInstance: APIManager = APIManager()
    
    private override init() {}
    
    private let baseUrl: String = "http://api.currencylayer.com/"
    private let accessKey: String = "ed77e0915315e85dfdb27ca2cf0bffaa"
    
    // First Method
    
    public func requestApiWithDictParam(
        dictParam: Dictionary<String,Any>,
        apiName: String,
        requestType: String,
        isAddCookie: Bool,
        completionHendler:@escaping (_ response:Dictionary<String,AnyObject>?, _ error: NSError?, _ success: Bool)-> Void) {
        
        var apiUrl = baseUrl
        apiUrl =  apiUrl.appendingFormat("%@", apiName)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: apiUrl)!
        
        let HTTPHeaderField_ContentType  = "Content-Type"
        let ContentType_ApplicationJson  = "application/json"
        var request = URLRequest.init(url: url)
        
        request.timeoutInterval = 60.0
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue(ContentType_ApplicationJson, forHTTPHeaderField: HTTPHeaderField_ContentType)
        request.httpMethod = requestType
        
        print(apiUrl)
        print(dictParam)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil   {
                completionHendler(nil, error as NSError?, false)
            }
            
            do {
                let resultJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                print("Request API = ", apiUrl)
                print("API Response = ", resultJson ?? "")
                completionHendler(resultJson, nil, true)
                
            } catch {
                completionHendler(nil, error as NSError?, false)
            }
        }
        dataTask.resume()
    }
    
    // Second Method
    public func requestApiWithUrlString(param: String, apiName: String,requestType: String, isAddCookie: Bool, completionHendler:@escaping (_ response:Dictionary<String,AnyObject>?, _ error: NSError?, _ success: Bool)-> Void ) {
        var apiUrl = "" // Your api url
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var request: URLRequest?
        
        if requestType == "GET" {
            
            apiUrl =  String(format: "%@%@&%@", baseUrl,apiName,param)
            apiUrl = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            print("URL=",apiUrl)
            
            let url = URL(string: apiUrl)!
            request = URLRequest.init(url: url)
            request?.httpMethod = "GET"
            
        } else {
            
            apiUrl =  String(format: "%@%@", baseUrl,apiName)
            apiUrl = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            print("URL=",apiUrl)
            
            let bodyParameterData = param.data(using: .utf8)
            let url = URL(string: apiUrl)!
            
            request = URLRequest(url: url)
            request?.httpBody = bodyParameterData
            request?.httpMethod = "POST"
        }
        
        request?.timeoutInterval = 60.0
        request?.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request?.httpShouldHandleCookies = true
        
        let dataTask = session.dataTask(with: request!) { (data, response, error) in
            
            if error != nil {
                completionHendler(nil, error as NSError?, false)
                return
            }
            
            do {
                if data != nil  {
                    let resultJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                    
                    print("Request API = ", apiUrl)
                    print("API Response = ",resultJson ?? "")
                    completionHendler(resultJson, nil, true)
                } else  {
                    completionHendler(nil, error as NSError?, false)
                }
            } catch {
                completionHendler(nil, error as NSError?, false)
            }
        }
        dataTask.resume()
    }
}

