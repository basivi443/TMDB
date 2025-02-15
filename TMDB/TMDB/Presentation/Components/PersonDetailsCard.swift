//
//  PersonDetailsCard.swift
//  TMDB
//
//  Created by Basivi Reddy on 15/02/25.
//

import SwiftUI

struct PersonDetailsCard: View {
    var model: KnownFor
    var body: some View {
        VStack{
            
            AsyncImageView(urlString: "https://image.tmdb.org/t/p/w600_and_h900_bestv2" + (model.posterPath ?? ""))
                .frame(height: 100,alignment: .top)
                .cornerRadius(10)          
        }
    }
}
