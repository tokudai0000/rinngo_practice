//
//  ContentView2.swift
//  rinngo_practice
//
//  Created by 齋藤祐希 on 2025/04/08.
//

import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    var text: String
    var fruit: String
}

struct SectionItem: Identifiable {
    var id = UUID()
    var lang: String
    var items: [Item]
}

struct ContentView2: View {
    var sectionItems = [
        SectionItem(lang: "日本語", items: [
            Item(text: "りんご", fruit: "Apple"),
            Item(text: "ぶどう", fruit: "Grape")
        ]),
        SectionItem(lang: "English", items: [
            Item(text: "Apple", fruit: "Apple"),
            Item(text: "Grape", fruit: "Grape")
        ])
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sectionItems) { sectionItem in
                    Section(header: Text(sectionItem.lang)) {
                        ForEach(sectionItem.items) { item in
                            NavigationLink(value: item.fruit) {
                                    Text(item.text)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: String.self) {image in
                Image(image)
            }
        }
    }
}

#Preview {
    ContentView2()
}
