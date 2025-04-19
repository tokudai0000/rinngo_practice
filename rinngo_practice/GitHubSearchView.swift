//
//  GitHubSearchView.swift
//  rinngo_practice
//
//  Created by 齋藤祐希 on 2025/04/18.
//

import SwiftUI
import Foundation

struct Repo: Decodable {
    let name: String
    let html_url: String
    let languages_url: String
}

struct RepoItem: Identifiable {
    let id = UUID()
    let name: String
    let langs: [String]
    let url: String
}

struct GitHubSearchView: View {
    var repoItems: [RepoItem] = []
    
    var body: some View {
        Text("Repository Search")
            .font(.title)
            .fontWeight(.bold)
        NavigationStack {
            ForEach(repoItems) { item in
                NavigationLink(value: item.url) {
                    Text(item.name)
                }
            }
        }
        .navigationDestination(for: String.self) { url in
            
        }
        
        Button("Tap") {
            Task {
                await fetchRepos()
            }
        }
    }
    
    func fetchRepos() async {
        let urlStr = "https://api.github.com/users/rinngo0302/repos"
        guard let url = URL(string: urlStr) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let repos = try JSONDecoder().decode([Repo].self, from: data)
            
            for repo in repos {
                print("\(repo.name): \(repo.html_url)")
                
                let langs = await fetchLangs(for: repo.languages_url)
                for lang in langs {
                    print(lang)
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }

    func fetchLangs(for url: String) async -> [String] {
        var langs: [String] = []
        
        guard let url = URL(string: url) else { return [] }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
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
    GitHubSearchView()
}
