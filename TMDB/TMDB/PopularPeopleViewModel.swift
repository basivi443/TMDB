//
//  PopularPeopleViewModel.swift
//  TMDB
//
//  Created by Basivi Reddy on 12/02/25.
//

import SwiftUI
import Combine

class PeopleViewModel: ObservableObject {
    @Published var peoples: [PeopleList] = []
    @Published var searchText = ""
    private var cancellables = Set<AnyCancellable>()
    @Published var isLoading = false
       private var currentPage = 1
    
    init() {
        fetchPeople()
    }
    
    func fetchPeople() {
        guard !isLoading else {
            return
        }
        isLoading = true
        let urlString = "https://api.themoviedb.org/3/person/popular?page=\(currentPage)&api_key=19b2da48826ec1cd74ed33419025f44f"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PopularPeopleModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    DispatchQueue.main.async { self.isLoading = false }
                case .finished:
                    DispatchQueue.main.async { self.isLoading = false }
                }
            }, receiveValue: { [weak self] response in
                if let peopleList = response.results{
                    DispatchQueue.main.async {
                        print(peopleList.count)
                        self?.peoples.append(contentsOf: peopleList)
                        self?.currentPage += 1
                        
                    }
                }else{
                    self?.isLoading = false
                }
                
            })
            .store(in: &cancellables)
    }
    
    

    
//    func searchPeople() {
//        let query = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//        let urlString = "https://api.themoviedb.org/3/search/person?query=\(query)&page=1&api_key=YOUR_API_KEY"
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map { $0.data }
//            .decode(type: PeopleResponse.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
//                self?.people = response.results
//            })
//            .store(in: &cancellables)
//    }
}
