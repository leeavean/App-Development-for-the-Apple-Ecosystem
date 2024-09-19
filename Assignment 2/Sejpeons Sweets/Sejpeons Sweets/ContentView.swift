//
//  ContentView.swift
//  Sejpeons Sweets
//
//  Created by Leevan on 24-5-24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            StoreLocatorView()
                .tabItem {
                    Label("Store Locations", systemImage: "mappin.and.ellipse")
                }
            
            ShoppingListView()
                .tabItem {
                    Label("Shopping List", systemImage: "cart.fill")
                }
        }
    }
}

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: MenuView()) {
                    Text("Menu")
                        .font(.title2)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: SpecialsView()) {
                    Text("Specials & Promotions")
                        .font(.title2)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white)
            .navigationBarTitleDisplayMode(.inline)
            
            .navigationBarItems(leading: HStack {
                Text("Sejpeons Sweets")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                Image("App")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 80)
            })
        }
    }
}


#Preview {
    ContentView()
}
