//
//  CustomTextField.swift
//  TMDB
//
//  Created by Basivi Reddy on 15/02/25.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
}
