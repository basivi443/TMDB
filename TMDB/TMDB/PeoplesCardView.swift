//
//  PeoplesCardView.swift
//  TMDB
//
//  Created by Basivi Reddy on 12/02/25.
//

import SwiftUI

struct PeoplesCardView: View {
    var model: PeopleList?
    var body: some View {
        HStack(alignment: .center) {
            Image("image") // Replace with your image asset
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .padding(.leading,16)
            Text("Miho Nomoto")
                .font(.headline)
                .foregroundColor(.black)
        }.frame(maxWidth: .infinity,alignment: .leading)
        
    }
}

struct PeoplesCardView_Previews: PreviewProvider {
    static var previews: some View {
        PeoplesCardView()
    }
}
