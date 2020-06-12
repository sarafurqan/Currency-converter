//
//  SettingView.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/10.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack{
            Text("Currency Converter")
                .font(.title)
            Text("Sara Furqan | Application Engineer")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
