//
//  PeoplesCardView.swift
//  TMDB
//
//  Created by Basivi Reddy on 12/02/25.
//

import SwiftUI

struct PeoplesCardView: View {
    var model: PeopleList
    var body: some View {
        HStack(alignment: .center) {
            AsyncImageView(urlString: "https://image.tmdb.org/t/p/w600_and_h900_bestv2" + (model.profilePath ?? ""))
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .padding(.leading,16)
            Text(model.name ?? "")
                .font(.headline)
                .foregroundColor(.black)
            
        }.frame(maxWidth: .infinity,alignment: .leading)
        
    }
}
