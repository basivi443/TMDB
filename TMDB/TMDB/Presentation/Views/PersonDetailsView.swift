//
//  PersonDetailsView.swift
//  TMDB
//
//  Created by Basivi Reddy on 14/02/25.
//

import SwiftUI

struct PersonDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    var model: PeopleList
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImageView(urlString: "https://image.tmdb.org/t/p/w600_and_h900_bestv2" + (model.profilePath ?? ""))
                .frame(height: 150)
                .cornerRadius(10)
                .padding()
            
            Text("Known For")
                .font(.title)
                .bold()
                .frame(alignment: .leading)
                .padding()
            
            
            ScrollView {
                LazyVGrid(columns: columns,spacing: 10) {
                    if let known = self.model.knownFor{
                        ForEach(known,id: \.id) { data in
                            PersonDetailsCard(model: data)
                        }
                    }
                }.padding()
            }.padding(.top,-30)
            
        }
        .navigationBarTitle(model.name ?? "", displayMode: .inline)
        .navigationBarBackButtonHidden(true) // Hides default back button
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left") // Custom back button
                .frame(maxWidth: 10, maxHeight: 10)
        }).tint(Color.black)
        
    }
}

struct PersonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(model: PeopleList())
    }
}


