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
    let description: String?
}

struct RepoItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let html_url: String
    let language_url: String
    let description: String?
}

struct GitHubSearchView: View {
    @State var repoItems: [RepoItem] = []
    
    @State var hasLoaded: Bool = false
    
    @State var token: String? = nil
    
    var body: some View {
        NavigationStack {
            Text("Repository Search")
                .font(.title)
                .fontWeight(.bold)
            
            // ProgressView
            if !hasLoaded {
                ProgressView()
                Spacer()
            } else {
                List {
                    ForEach(repoItems) { item in
                        NavigationLink(value: item) {
                            VStack(alignment: .leading) {
                                // repository name
                                Text(item.name)
                                
                                // description
                                Text(item.description ?? "")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .navigationDestination(for: RepoItem.self) { item in
                    RepoView(repoItem: item)
                }
                .refreshable {
                    Task {
                        repoItems = await fetchRepos(with: token) ?? []
                    }
                }
            }
        }
        .onAppear {
            Task {
                self.token = Bundle.main.infoDictionary?["GITHUB_API_TOKEN"] as? String
                
                if let repoitems: [RepoItem] = await fetchRepos(with: token) {
                    repoItems = repoitems
                    hasLoaded = true
                    print("リポジトリの情報の取得成功")
                                        
                } else {
                    print("リポジトリの情報の取得ができませんでした")
                }
            }
        }
    }
    
    func fetchRepos(with token: String?) async -> [RepoItem]? {
        let urlStr = "https://api.github.com/users/rinngo0302/repos"
        guard let url = URL(string: urlStr) else { return nil }
        
        do {
            var request = URLRequest(url: url)
            
            // Token
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
            
            let repos = try JSONDecoder().decode([Repo].self, from: data)
            
            var repoItems: [RepoItem] = []
            for repo in repos {
                repoItems.append(RepoItem(name: repo.name, html_url: repo.html_url, language_url: repo.languages_url, description: repo.description))
            }
            
            return repoItems
        } catch {
            print("Error: \(error)")
            
            return nil
        }
    }
}

#Preview {
    GitHubSearchView()
}
