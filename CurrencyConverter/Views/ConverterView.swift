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
    @State var resultCount: Int = 0
    @State var shouldShowCurrencyList: Bool = false
    @State var indexSelectedCurrency: Int = 0
    
    let currencyList: [String] = ["USD", "JPY", "PKR"]
    var selectedCurrency: String {
        currencyList[indexSelectedCurrency]
    }
    var exchangeCurrency: String {
        "GBP"
    }
    
    var body: some View {
        VStack {
            // Header View
            headerView
            
            // Result View
            resultView
            
            Spacer()
        }.padding(10)
    }
    
    var resultView: some View {
        VStack(alignment: .leading) {
            Text("Result (\(resultCount))")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                .padding(.bottom, 10)
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
                    // conversion rate for selected currency
                    self.model.conversionRate(
                        from: self.selectedCurrency,
                        to: self.exchangeCurrency,
                        amount: self.searchedAmount)
                })
                .keyboardType(.decimalPad)
                .frame(height: 40)
                .border(Color.gray, width: 2)
                .padding(.top, 20)
                .padding(.bottom, 10)
            
            Button(action: {
                // Show currency list
                print(self.searchedAmount)
                self.shouldShowCurrencyList = true
            }) {
                HStack {
                    Text(selectedCurrency)
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
            .padding(.bottom, 10)
            
            Divider().background(Color.gray)
        }
        .sheet(
            isPresented: $shouldShowCurrencyList,
            onDismiss: {
                // conversion rate for selected currency
                self.model.conversionRate(
                    from: self.selectedCurrency,
                    to: self.exchangeCurrency,
                    amount: self.searchedAmount)
        })
        {
            // list of currencies
            List(0..<self.currencyList.count) { index in
                Text(self.currencyList[index])
            }
        }
    }
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView()
    }
}
