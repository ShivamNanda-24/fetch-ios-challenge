//
//  ContentView.swift
//  fetch-challenge-ios
//
//  Created by Shivam Nanda on 10/5/23.
//

/*
 ContentView displays desserts fetched from the API in a list format.
 */
import SwiftUI

struct ContentView: View {
    
    @State private var desserts: [Dessert] = []
    @State private var selectedDessert: Dessert? = nil

    var body: some View {
        NavigationView {
            VStack {
                Text("Desserts")
                
                // Create a List view to display the desserts.
                List(desserts, id: \.idMeal) { item in
                    // NavigationLink to create a link to the DetailView.
                    NavigationLink(destination: DetailView(dessert: item), tag: item, selection: $selectedDessert) {
                        Text(item.strMeal)
                    }
                }
                .onAppear {
                    // Fetch desserts when the view appears.
                    fetchDesserts { result in
                        switch result {
                        case .success(let fetchedDesserts):
                            // Update desserts on success.
                            self.desserts = fetchedDesserts
                        case .failure(let error):
                            // Handle the error, e.g., display an error message.
                            print("Failed to fetch desserts: \(error)")
                        }
                    }
                }
            }
        }
    }
}

