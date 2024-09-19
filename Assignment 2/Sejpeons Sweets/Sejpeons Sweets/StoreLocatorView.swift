//
//  StoreLocatorView.swift
//  Sejpeons Sweets
//
//  Created by Leevan on 24-5-24.
//

import SwiftUI
import MapKit

struct StoreLocatorView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -31.9505, longitude: 115.8605),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State private var stores: [Store] = []

    var body: some View {
        Map(coordinateRegion: $region, interactionModes: .all, annotationItems: stores) { store in
            MapPin(coordinate: CLLocationCoordinate2D(latitude: store.lat, longitude: store.long), tint: .red)
        }
        .navigationTitle("Map")
        .task {
            do {
                let url = URL(string: "https://davidmcmeekin.com/comp2010/StoreLocations.json")!
                let (data, _) = try await URLSession.shared.data(from: url)
                stores = try JSONDecoder().decode([Store].self, from: data)
            } catch {
                print("Error in loading data: \(error)")
            }
        }
    }
}

struct Store: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let lat: Double
    let long: Double
}

#Preview {
    StoreLocatorView()
}
