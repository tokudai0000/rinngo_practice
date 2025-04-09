//
//  ContentView2.swift
//  rinngo_practice
//
//  Created by 齋藤祐希 on 2025/04/08.
//

import SwiftUI

struct ContentView2: View {
    var body: some View {
        List {
            Section(header: Text("日本語")) {
                Text("りんご")
                Text("ぶどう")
            }
            Section(header: Text("English")) {
                Text("Apple")
                Text("Grape")
            }
        }
    }
}

#Preview {
    ContentView2()
}
