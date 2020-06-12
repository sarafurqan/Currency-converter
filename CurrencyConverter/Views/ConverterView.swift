//
//  ConverterView.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/10.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import SwiftUI

struct ConverterView: View {
    
    @ObservedObject var model: CurrencyConverterModel = CurrencyConverterModel()
    @State var searchedAmount: String = ""
    @State var shouldShowCurrencyList: Bool = false
    
    var selectedCurrency: CountryCurrency? {
        self.model.availableCurrencies?[self.model.indexSelectedCurrency]
    }
    
    var body: some View {
        VStack {
            // Header View
            headerView
            // Result View
            resultView
        }
        .padding(10)
        .padding(.top, .zero)
        .sheet(isPresented: $shouldShowCurrencyList) {
            // list of currencies
            if self.model.availableCurrencies?.count ?? 0 > 0 {
                List(0..<self.model.availableCurrencies!.count) { index in
                    Button(action: {
                        self.model.indexSelectedCurrency = index
                        self.shouldShowCurrencyList = false
                    }) {
                        HStack {
                            Text("\(self.model.availableCurrencies![index].code)")
                            Spacer()
                            Text("\(self.model.availableCurrencies![index].name)")
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .alert(isPresented: self.$model.showAlert) {
            Alert(title: Text(self.model.errorMessage))
        }
        .onAppear {
            
            // check local storage
            let defaults = UserDefaults.standard
            
            if self.model.availableCurrencies == nil {
                if let currencies = defaults.object(forKey: UserDefaultKey.currencyList.rawValue) as? Data, let loadedCurrencies = try? PropertyListDecoder().decode(Array<CountryCurrency>.self, from: currencies) as [CountryCurrency] {
                    self.model.availableCurrencies = loadedCurrencies
                } else {
                    self.model.loadAvailableCurrencies()
                }
            }
            
            if self.model.convertedRates == nil {
                if let rates = defaults.object(forKey: UserDefaultKey.exchangeRates.rawValue) as? Data, let loadedRates = try? PropertyListDecoder().decode(Array<ExchangeRate>.self, from: rates) as [ExchangeRate] {
                    self.model.exchangeRates = loadedRates
                } else {
                    self.model.loadLiveExchangeRates()
                }
            }
        }
    }
    
    var headerView: some View {
        VStack {
            TextField(
                "Enter amount here",
                text: $searchedAmount,
                onCommit: {
                    self.searchedAmount = self.searchedAmount.reduce("") {
                        if ("0"..."9").contains($1) || $1 == "." && !$0.contains($1) {
                            return $0 + "\($1)"
                        }
                        return $0
                    }
                    // load conversion rate for selected currency
                    self.convertCurrency()
            })
                .keyboardType(.decimalPad)
                .frame(height: 40)
                .border(Color.gray, width: 2)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            HStack {
                Button("Convert", action: {
                    print(self.searchedAmount)
                    // load conversion rate for selected currency
                    self.convertCurrency()
                })
                
                Button(action: {
                    // Show currency list
                    self.shouldShowCurrencyList = true
                }) {
                    HStack {
                        Text(selectedCurrency?.code ?? "")
                            .multilineTextAlignment(.trailing)
                            .padding(.leading, 10)
                            .padding(.trailing, 5)
                        Image(systemName: "chevron.down") // down arrow
                            .padding(.leading, 5)
                            .padding(.trailing, 10)
                    }
                }
                .border(Color.gray, width: 1)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.bottom, 10)
            
            Divider().background(Color.gray)
        }
    }
    
    var resultView: some View {
        VStack(alignment: .leading) {
            Text("Result (\(model.convertedRates?.count ?? 0))")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            Divider().background(Color.gray)
            if model.convertedRates != nil {
                List(0..<self.model.convertedRates!.count) { index in
                    HStack {
                        Text("\(self.model.convertedRates![index].currency)")
                        Spacer()
                        Text("\(self.model.convertedRates![index].rate)")
                    }
                    .frame(maxWidth: .infinity)
                }.padding(.bottom, .zero)
            }
        }
    }
    
    func convertCurrency() {
        // conversion rate for selected currency
        self.model.convertAmount(
            for: self.model.availableCurrencies?[self.model.indexSelectedCurrency].code,
            amount: Double(self.searchedAmount) ?? 1)
    }
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView()
    }
}
