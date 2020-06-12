//
//  CurrencyConverterModel.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/10.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import SwiftUI

enum UserDefaultKey: String {
    case exchangeRates = "exchangeRates"
    case currencyList = "currencyList"
}

class CurrencyConverterModel: ObservableObject {
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var indexSelectedCurrency: Int = 0
    @Published var availableCurrencies: [CountryCurrency]?
    @Published var exchangeRates: [ExchangeRate]?
    
    // used for Conversion API (not free)
    private var conversionAmount: Double = 1
    
    func convertAmount(for currency: String? = "USD", amount: Double) {
        let rate: Double = 1
        amount * rate
    }
    
    // MARK:- Currency list API
    
    func loadAvailableCurrencies() {
        CurrencyListRequest.sharedInstance.getAllCurrencies(
            success: { (response) in
                DispatchQueue.main.async {
                    self.availableCurrencies = response?.currencies?.compactMap({
                        CountryCurrency(
                            code: $0.0,
                            name: $0.1)
                    })
                    
                    /*
                     * using userdefaults as fastest solution
                     * for the sake of this test
                     * Would use core data, if have time
                     */
                    if let currencies = self.availableCurrencies {
                        do {
                            try UserDefaults.standard.setValue(
                                NSKeyedArchiver.archivedData(
                                    withRootObject: currencies,
                                    requiringSecureCoding: false),
                                forKey: UserDefaultKey.currencyList.rawValue)
                        } catch {
                            print("Could not save data")
                        }
                    }
                }
        },
            failure: { (error) in
                print ("Couldn't get currency list")
        })
    }

    // MARK:- Live exchange API
    
    func loadLiveExchangeRates() {
        LiveExchangeRequest.sharedInstance.getLiveExchange(
            success: { (response) in
                DispatchQueue.main.async {
                    self.exchangeRates = response?.quotes.compactMap({
                        ExchangeRate(
                            currency: $0.0,
                            rate: $0.1)
                    })
                    
                    /*
                     * using userdefaults as fastest solution
                     * for the sake of this test
                     * Would use core data, if have time
                     */
                    if let rates = self.exchangeRates {
                        do {
                            try UserDefaults.standard.setValue(
                                NSKeyedArchiver.archivedData(
                                    withRootObject: rates,
                                    requiringSecureCoding: false),
                                forKey: UserDefaultKey.exchangeRates.rawValue)
                        } catch {
                            print("Could not save data")
                        }
                    }
                }
            },
            failure: { (error) in
                print ("Couldn't get live exchange rate")
            })
    }
    
    // MARK:- Conversion API
    
    /*
     * Can be used for converting amount to a specific currency
     * Not available for free.
     */
    func loadConversionRate(from: String, to: String, amount: String) {
        CurrencyConversionRequest.sharedInstance.convertCurrency(
            from: from,
            to: to,
            amount: amount,
            success: { (response) in
                DispatchQueue.main.async {
                    self.conversionAmount = response?.result ?? 0
                }
            },
            failure: { (error) in
                print ("Couldn't convert currencies")
            })
    }
}
