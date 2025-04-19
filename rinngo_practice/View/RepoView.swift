//
//  RepoView.swift
//  rinngo_practice
//
//  Created by 齋藤祐希 on 2025/04/19.
//

import SwiftUI

struct RepoView: View {
    var repoItem: RepoItem
    @State var langs: [String] = []
    
    @State var hasLoaded: Bool = false
    
    var body: some View {
        Text(repoItem.name)
            .font(.title)
            .fontWeight(.bold)
            .onAppear {
                Task {
                    let token = Bundle.main.infoDictionary?["GITHUB_API_TOKEN"] as? String
                    
                    self.langs = await fetchLangs(for: repoItem.language_url, with: token) ?? []
                    
                    hasLoaded = true
                }
            }
        
        if !hasLoaded {
            ProgressView()
            Spacer()
        } else {
            List {
                Section(header: Text("基本情報")) {
                    CustomCell(label: "URL", value: "[\(repoItem.html_url)](\(repoItem.html_url))")
                }
                if !langs.isEmpty {
                    Section(header: Text("言語")) {
                        ForEach(langs, id: \.self) { lang in
                            Text(lang)
                        }
                    }
                }
            }
        }
    }
    
    func fetchLangs(for url: String, with token: String?) async -> [String]? {
        var langs: [String] = []
        
        guard let url = URL(string: url) else { return nil }
        
        do {
            var request = URLRequest(url: url)
            
            // Tokenの取得
            if let token = token {
                request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
                
                print("token: \(token)")
            } else {
                print("トークンを取得できませんでした")
            }

            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("ステータスコード: \(httpResponse.statusCode)")
            }

            if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                for (key, _) in jsonData {
                    langs.append(key)
                }
            }
        } catch {
            print("Error: \(error)")
        }
        
        return langs
    }
}

#Preview {
    RepoView(repoItem: RepoItem(name: "test", html_url: "https://example.com", language_url: "https://api.github.com/repos/rinngo0302/GameCreateSampleGame/languages"), langs: ["Swift", "Objective-C"])
}
