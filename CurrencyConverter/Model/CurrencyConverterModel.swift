//
//  CurrencyConverterModel.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/10.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import SwiftUI

class CurrencyConverterModel: ObservableObject {
    
    @State var liveModel: LiveExchangeResponse?
    @Published var conversionRate: CurrencyConversionRequest?
    @Published var currencies: CurrencyListResponse?
    
    func liveExchangeRate() {
        LiveExchangeRequest.sharedInstance.getLiveExchange(
            success: { (response) in
                self.liveModel = response
                print ("success in currency converter model")
            },
            failure: { (error) in
                print ("Couldn't get live exchange rate")
            })
    }
    
    func conversionRate(from: String, to: String, amount: String) {
        CurrencyConversionRequest.sharedInstance.convertCurrency(
            from: from,
            to: to,
            amount: amount,
            success: { (response) in
                
            },
            failure: { (error) in
                print ("Couldn't convert currencies")
            })
    }
    
    func availableCurrencies() {
        CurrencyListRequest.sharedInstance.getAllCurrencies(
            success: { (response) in
                
            },
            failure: { (error) in
                print ("Couldn't get currency list")
            })
    }
}
