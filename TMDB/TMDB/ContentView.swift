//
//  ContentView.swift
//  TMDB
//
//  Created by Basivi Reddy on 09/02/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PeopleViewModel()
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.peoples, id: \.id){ people in
                        if let p = people{
                            PeoplesCardView(model: p)
                                .onAppear {
                                    if people.id == viewModel.peoples.last?.id {
                                        viewModel.fetchPeople()
                                    }
                                }
                        }
                    }
                    if viewModel.isLoading {
                        ProgressView("Loading more...")
                            .padding()
                    }
                }
            }
           
            .searchable(text: $searchText, prompt: "Search People")
            .onChange(of: searchText) { newValue in
                viewModel.searchText = newValue
                viewModel.setupSearch()
            }
            .padding()
            .navigationTitle("Search")
        }
        
      
       
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct AsyncImageView: View {
    let urlString: String
    @State private var image: UIImage?

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                    .padding(.leading,16)
            } else {
                Image("image")
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(25)
                    .padding(.leading,16)
                    .task {
                        image = await loadImage(from: urlString)
                    }
            }
        }
    }
    
    func loadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print("Failed to load image: \(error)")
            return nil
        }
    }
}
