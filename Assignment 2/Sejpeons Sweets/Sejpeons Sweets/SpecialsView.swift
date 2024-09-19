//
//  SpecialsView.swift
//  Sejpeons Sweets
//
//  Created by Leevan on 24-5-24.
//

import SwiftUI

struct SpecialsView: View {
    @State private var specials: [Special] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(specials) { special in
                    HStack(alignment: .top, spacing: 15) {
                        Image(systemName: special.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                        
                        VStack(alignment: .leading) {
                            Text(special.productName)
                                .font(.headline)
                                .foregroundColor(.red)
                            Text(special.description)
                                .font(.subheadline)
                            Text("Was: \(special.wasPrice, specifier: "%.2f")")
                                .strikethrough()
                                .foregroundColor(.gray)
                            Text("Now: \(special.nowPrice, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
            }
            .padding()
        }
        .navigationTitle("Specials & Promotions")
        .task {
            do {
                let url = URL(string: "https://davidmcmeekin.com/comp2010/ListSpecials.json")!
                let (data, _) = try await URLSession.shared.data(from: url)
                specials = try JSONDecoder().decode([Special].self, from: data)
            } catch {
                print("Error in loading data: \(error)")
            }
        }
    }
}

struct Special: Identifiable, Decodable {
    let id = UUID()
    let productName: String
    let description: String
    let wasPrice: Double
    let nowPrice: Double
    let image: String
}

#Preview {
    SpecialsView()
}
