//
//  AsyncImageView.swift
//  TMDB
//
//  Created by Basivi Reddy on 15/02/25.
//

import SwiftUI

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

