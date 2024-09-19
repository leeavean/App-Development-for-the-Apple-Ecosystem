//
//  ShoppingListView.swift
//  Sejpeons Sweets
//
//  Created by Leevan on 24-5-24.
//

import SwiftUI

struct ShoppingListView: View {
    @State private var shoppingList: [ShoppingListItem] = []
    @State private var newItemName: String = ""
    @State private var newItemQuantity: Int = 1
    @State private var newItemPrice: String = ""

    var body: some View {
        VStack {
            List {
                ForEach(shoppingList, id: \.id) { item in
                    ShoppingListItemView(item: item, onDelete: deleteItem)
                }
            }

            HStack {
                TextField("New Item", text: $newItemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Stepper(value: $newItemQuantity, in: 1...100) {
                    Text("Qty: \(newItemQuantity)")
                }
            }
            .padding()

            TextField("Price", text: $newItemPrice)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button(action: addItem) {
                Text("Add Item")
                    .font(.title2)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Shopping List")
        .onAppear(perform: loadShoppingList)
    }

    private func loadShoppingList() {
        // Implement loading logic from UserDefaults
        if let data = UserDefaults.standard.data(forKey: "shoppingList") {
            if let decodedList = try? JSONDecoder().decode([ShoppingListItem].self, from: data) {
                shoppingList = decodedList
            }
        }
    }

    private func saveShoppingList() {
        // Implement saving logic to UserDefaults
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(shoppingList) {
            UserDefaults.standard.set(encoded, forKey: "shoppingList")
        }
    }

    private func addItem() {
        guard !newItemName.isEmpty, let price = Double(newItemPrice) else { return }
        let newItem = ShoppingListItem(name: newItemName, quantity: newItemQuantity, price: price)
        shoppingList.append(newItem)
        newItemName = ""
        newItemQuantity = 1
        newItemPrice = ""
        saveShoppingList()
    }

    private func deleteItem(_ item: ShoppingListItem) {
        shoppingList.removeAll { $0.id == item.id }
        saveShoppingList()
    }
}

struct ShoppingListItem: Identifiable, Codable {
    let id = UUID()
    var name: String
    var quantity: Int
    var price: Double
}


struct ShoppingListItemView: View {
    let item: ShoppingListItem
    let onDelete: (ShoppingListItem) -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text("Quantity: \(item.quantity)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(String(format: "Price: $%.2f", item.price))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(String(format: "Total: $%.2f", item.price * Double(item.quantity)))
                    .font(.subheadline)
                    .foregroundColor(.green)
            }

            Spacer()

            Button(action: {
                onDelete(item)
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    ShoppingListView()
}
