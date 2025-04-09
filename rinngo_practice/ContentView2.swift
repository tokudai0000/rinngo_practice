//
//  ContentView2.swift
//  rinngo_practice
//
//  Created by 齋藤祐希 on 2025/04/08.
//

import SwiftUI

struct ContentView2: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("日本語")) {
                    NavigationLink(destination: AppleImage()) {
                        Text("りんご")
                    }
                    NavigationLink(destination: GrapeImage()) {
                        Text("ぶどう")
                    }
                }
                Section(header: Text("English")) {
                    NavigationLink(destination: AppleImage()) {
                        Text("Apple")
                    }
                    NavigationLink(destination: GrapeImage()) {
                        Text("Grape")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView2()
}
