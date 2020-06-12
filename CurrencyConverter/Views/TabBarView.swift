//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Furqan, Syeda | Sara | TPDD on 2020/06/10.
//  Copyright © 2020 Furqan, Sara. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            ConverterView()
                .tabItem {
                    VStack {
                        Image("first")
                        Text("Converter")
                    }
                }
                .tag(0)
            SettingView()
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Author")
                    }
                }
                .tag(1)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
