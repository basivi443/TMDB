//
//  PopularPeopleViewModel.swift
//  TMDB
//
//  Created by Basivi Reddy on 12/02/25.
//

import SwiftUI
import Combine

class PeopleViewModel: ObservableObject {
    @Published var people: PopularPeopleModel?
    @Published var searchText = ""
    private var cancellables = Set<AnyCancellable>()
    private var page = 1
    
    init() {
        fetchPeople()
    }
    
    func fetchPeople() {
        let urlString = "https://api.themoviedb.org/3/person/popular?page=\(page)&api_key=YOUR_API_KEY"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PopularPeopleModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                guard let responseModel = response else { return }
                if let peopleList = responseModel.results{
                    self?.people?.results?.append(contentsOf: peopleList)
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
