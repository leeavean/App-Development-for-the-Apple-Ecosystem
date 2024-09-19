//
//  MenuView.swift
//  Sejpeons Sweets
//
//  Created by Leevan on 24-5-24.
//

import SwiftUI

struct MenuView: View {
    @State private var products: [Product] = [
        Product(name: "Mango lolly", description: "Mango flavor", price: 19.75, imageName: "mango"),
        Product(name: "Palestine", description: "Watermelon flavor", price: 25.99, imageName: "watermelon"),
        Product(name: "Choc Babies Allseps", description: "Chocolate flavoured brown jelly babies lollies", price: 16.75, imageName: "Choc"),
        Product(name: "Choc Bullets Milk Fyna", description: "Licorice Bullets covered in creamy Milk Chocolate", price: 13.75, imageName: "bullet")
    ]
    
    var body: some View {
        List(products) { product in
            NavigationLink(destination: ProductDetailView(product: product)) {
                Text(product.name)
                    .foregroundColor(.pink)
            }
        }
        .navigationTitle("Menu")
    }
}

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let price: Double
    let imageName: String
}

#Preview {
    MenuView()
}
