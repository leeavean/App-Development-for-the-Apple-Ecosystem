//
//  ProductDetailView.swift
//  Sejpeons Sweets
//
//  Created by Leevan on 24-5-24.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        VStack(spacing: 20) {
            Image(product.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding()

            Text(product.name)
                .font(.largeTitle)
                .padding()

            Text(product.description)
                .font(.body)
                .padding()

            Text(String(format: "$%.2f", product.price))
                .font(.title)
                .padding()
        }
        .navigationTitle(product.name)
    }
}

#Preview {
    ProductDetailView(product: Product(name: "Palestine", description: "Watermelon flavor", price: 25.99, imageName: "watermelon"))
}
