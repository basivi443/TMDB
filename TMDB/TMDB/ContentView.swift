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
            VStack{
                CustomTextField(text: $searchText, placeholder: "Search People")
                    .padding()
                    .onChange(of: searchText) { newValue in
                        viewModel.searchText = newValue
                        if viewModel.searchText.isEmpty{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                viewModel.fetchPeople()
                            }
                        }else{
                            viewModel.setupSearch()
                        }
                    }
                
                ScrollView {
                    
                    
                    
                    LazyVStack {
                        ForEach(viewModel.peoples, id: \.id){ people in
                            NavigationLink(destination: PersonDetailsView(model: people)) {
                                if let p = people{
                                    PeoplesCardView(model: p)
                                        .onAppear {
                                            if people.id == viewModel.peoples.last?.id {
                                                viewModel.fetchPeople()
                                            }
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
                .navigationTitle("Popular People")
            }
        }
        
        
        
    }
}

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
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
            } else {
                Image("image")
                    .aspectRatio(contentMode: .fill)
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
