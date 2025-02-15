//
//  HomeView.swift
//  TMDB
//
//  Created by Basivi Reddy on 15/02/25.
//

import SwiftUI
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
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
                                viewModel.getPopulaPeopleApi()
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
                                                viewModel.getPopulaPeopleApi()
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
