//
//  ContentView.swift
//  Neppatsrev Coffee
//
//  Created by Leevan on 11-4-24.
//

import SwiftUI
import MapKit

// Define the main ContentView
struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeView()
                .navigationBarTitle("Neppatsrev Coffee")
                .navigationBarItems(trailing:
                                        NavigationLink(destination: CartView()) {
                    Image(systemName: "cart")
                        .foregroundColor(.brown)
                }
                    .padding(.horizontal)
                    .padding(.top, 10)
                )
        }
    }
}

// Home screen
struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Welcome to Neppatsrev Coffee!")
                        .font(.title)
                        .foregroundColor(.brown)
                    Image(systemName: "cup.and.saucer.fill")
                        .foregroundColor(.brown)
                        .font(.title)
                }
                
                NavigationLink(destination: MenuView()) {
                    Text("Order")
                        .padding()
                        .background(Color.brown)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: StoreLocatorView()) {
                    Text("Find a Store")
                        .padding()
                        .background(Color.brown)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: LoyaltyCardView()) {
                    Text("Loyalty Card")
                        .padding()
                        .background(Color.brown)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }

    }
}

// Model for menu items
struct Item: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var price: Double
    var customizationOptions: [String]
    var imageName: String
}

// Menu screen
struct MenuView: View {
    var body: some View {
        List {
            Section(header: Text("Beverages")) {
                ForEach(drinks, id: \.id) { drink in
                    NavigationLink(destination: DrinkCustomizationView(item: drink)) {
                        MenuItemView(item: drink)
                    }
                }
            }
            
            Section(header: Text("Food")) {
                ForEach(foods, id: \.id) { food in
                    NavigationLink(destination: FoodCustomizationView(item: food)) {
                        MenuItemView(item: food)
                    }
                }
            }
        }
        .navigationBarTitle("Menu")
    }
}

// Menu item view
struct MenuItemView: View {
    var item: Item
    
    var body: some View {
        HStack{
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("$\(item.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
        }
    }
}

// Drink customization screen
struct DrinkCustomizationView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var selectedSize = "M"
    @State private var selectedMilk = "Almond Milk"
    @State private var selectedChocolate = "Dark Chocolate"
    @State private var sugarCount: Int = 0
    @State private var shotsCount: Int = 0
    @State private var showingCart = false
    
    var item: Item
    
    var body: some View {
        VStack {
            Text("Edit your \(item.name) :)")
                .font(.title)
            
            Picker("Size", selection: $selectedSize) {
                Text("Small").tag("S")
                Text("Medium").tag("M")
                Text("Large").tag("L")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Picker("Milk", selection: $selectedMilk) {
                Text("Almond Milk").tag("Almond Milk")
                Text("Fresh Milk").tag("Fresh Milk")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Stepper("Sugar: \(sugarCount)", value: $sugarCount, in: 0...10)
            
            Stepper("Shots: \(shotsCount)", value: $shotsCount, in: 0...5)
            
            Button(action: {
                // Add item to cart
                let customization = "Size: \(selectedSize), Milk: \(selectedMilk), Sugar: \(sugarCount), Shots: \(shotsCount)"
                cartManager.addItem(item, customization: customization, quantity: 1)
                showingCart = true // Show cart
            }) {
                Text("Add to Cart")
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarTitle("Customize \(item.name)")
        .sheet(isPresented: $showingCart) {
            NavigationView {
                CartView()
                    .environmentObject(cartManager)
            }
        }
    }
}

// Food customization screen
struct FoodCustomizationView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var tomatoCount: Int = 0
    @State private var lettuceCount: Int = 0
    @State private var cheeseCount: Int = 0
    @State private var showingCart = false
    
    var item: Item
    
    var body: some View {
        VStack {
            Text("Edit your \(item.name) :)")
                .font(.title)
            
            Stepper("Tomato: \(tomatoCount)", value: $tomatoCount, in: 0...5)
                .padding()
            
            Stepper("Lettuce: \(lettuceCount)", value: $lettuceCount, in: 0...5)
                .padding()
            
            Stepper("Cheese: \(cheeseCount)", value: $cheeseCount, in: 0...5)
                .padding()
            
            Button(action: {
                let customization = "Tomato: \(tomatoCount), Lettuce: \(lettuceCount), Cheese: \(cheeseCount)"
                cartManager.addItem(item, customization: customization, quantity: 1)
                showingCart = true
            }) {
                Text("Add to Cart")
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarTitle("Customize \(item.name)")
        .sheet(isPresented: $showingCart) {
            NavigationView {
                CartView()
                    .environmentObject(cartManager)
            }
        }
    }
}

// drink items
let drinks = [
    Item(name: "Latte", description: "Espresso with steamed milk", price: 3.50, customizationOptions: ["Milk", "Shots", "Size", "Sugar"], imageName: "Latte" ),
    Item(name: "Cappuccino", description: "Espresso with equal parts steamed milk and foam", price: 3.75, customizationOptions: ["Milk", "Shots", "Size", "Sugar"], imageName: "Cappuccino"),
    Item(name: "Hot Chocolate", description: "Steamed milk with chocolate syrup", price: 4.00, customizationOptions: ["Milk", "Size", "Sugar", "Chocolate"], imageName: "Hot Choc"),
    Item(name: "Matcha Latte", description: "Matcha with steamed milk", price: 4.25, customizationOptions: ["Milk", "Size", "Shots", "Chocolate"], imageName: "Matcha")
]

// food items
let foods = [
    Item(name: "Avocado Sandwich", description: "Fresh avocado with choice of meat on multigrain bread", price: 7.50, customizationOptions: ["Tomato", "Cheese slice", "Beef", "Chicken"], imageName: "Avo"),
    Item(name: "Bondi Burger", description: "Grilled beef patty with cheddar cheese and lettuce", price: 9.00, customizationOptions: ["Cheese slice", "Tomato"], imageName: "Burger")
]

// Cart item struct
struct CartItem: Identifiable {
    var id = UUID()
    var item: Item
    var customization: String
    var quantity: Int
}

// Manage cart
class CartManager: ObservableObject {
    @Published var cartItems: [CartItem] = []
    
    func addItem(_ item: Item, customization: String, quantity: Int) {
        let cartItem = CartItem(item: item, customization: customization, quantity: quantity)
        cartItems.append(cartItem)
    }
    
    func removeItem(at index: Int) {
        cartItems.remove(at: index)
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
}

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            ForEach(cartManager.cartItems) { cartItem in
                VStack(alignment: .leading) {
                    Text("\(cartItem.item.name) (\(cartItem.customization))")
                        .font(.headline)
                    Text("Quantity: \(cartItem.quantity)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Total: $\(cartItem.item.price * Double(cartItem.quantity), specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.green)
                    Button(action: {
                        deleteCartItem(cartItem)
                    }) {
                        Text("Clear")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .navigationBarTitle("Cart")
        .navigationBarItems(trailing:
            NavigationLink(destination: CheckoutView()) {
                Text("Checkout")
            }
        )
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                }
            }
        }
    }
    
    func deleteCartItem(_ cartItem: CartItem) {
        if let index = cartManager.cartItems.firstIndex(where: { $0.id == cartItem.id }) {
            cartManager.cartItems.remove(at: index)
        }
    }
}

// Checkout screen
struct CheckoutView: View {
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var cardNumber = ""
    @State private var expirationDate = ""
    @State private var cvv = ""
    @State private var Name = ""
    @State private var Mobile = ""
    
    var total: Double {
        var totalPrice = 0.0
        for cartItem in cartManager.cartItems {
            totalPrice += cartItem.item.price * Double(cartItem.quantity)
        }
        return totalPrice
    }
    var body: some View {
        VStack {
            List {
                ForEach(cartManager.cartItems) { cartItem in
                    VStack(alignment: .leading) {
                        Text("\(cartItem.item.name) (\(cartItem.customization))")
                            .font(.headline)
                        Text("Quantity: \(cartItem.quantity)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Total: $\(cartItem.item.price * Double(cartItem.quantity), specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.green)
                    }
                }
            }
            
            // Payment details
            TextField("Name", text: $Name)
                .padding()
            TextField("Phone number", text: $Mobile)
                .padding()
            TextField("Credit Card Number", text: $cardNumber)
                .padding()
            TextField("Expiration Date", text: $expirationDate)
                .padding()
            SecureField("CVV", text: $cvv)
                .padding()
            
            // Display total price
            Text("Total Price: $\(total, specifier: "%.2f")")
                .font(.headline)
                .padding()
            
            Button(action: {
                cartManager.clearCart()
                
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Confirm Order")
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarTitle("Checkout")
    }
}

struct LoyaltyCardView: View {
    let barcodeImage: String = "QR code"
    let memberName: String = "Mohamed Leevan" // Member's name
    let coffeeConsumed: Int = 5 // Number of Neppatsrev Coffee consumed by the member

    var body: some View {
        VStack {
            // Display barcode image
            Image("QR code")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()

            // Display member's name
            Text("Member: \(memberName)")
                .font(.headline)
                .padding()

            // Display number of Neppatsrev Coffee consumed
            Text("Coffee Consumed: \(coffeeConsumed)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
        }
        .navigationBarTitle("Loyalty Card")
    }
}

struct StoreLocation {
    let latitude: Double
    let longitude: Double
}

let storeLocations = [
    StoreLocation(latitude: -31.9505, longitude: 115.8605), // Perth City
    StoreLocation(latitude: -31.9802, longitude: 115.8784), // South Perth
    StoreLocation(latitude: -31.9680, longitude: 115.8444), // Subiaco
    StoreLocation(latitude: -31.9877, longitude: 115.8713) // Como
]

struct StoreLocatorView: View {
    var body: some View {
        MapView(locations: storeLocations)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Locations")
    }
}

struct MapView: UIViewRepresentable {
    let locations: [StoreLocation]

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.removeAnnotations(view.annotations)
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            view.addAnnotation(annotation)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let cartManager = CartManager()
        return ContentView()
            .environmentObject(cartManager)
    }
}

// Images are from https://www.pexels.com and https://unsplash.com 
