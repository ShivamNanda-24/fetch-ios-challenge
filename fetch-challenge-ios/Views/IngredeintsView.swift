//
//  IngredeintsView.swift
//  fetch-challenge-ios
//
//  Created by Shivam Nanda on 10/6/23.
//

import SwiftUI

/*
 Displays the ingredients and measurements next to each other.
 */
struct IngredeintsView: View {
    
    let recipe: Recipe
    var body: some View {
        ForEach(recipe.ingredientsAndMeasurements, id: \.self) { ingredient in
            if let ingredientName = ingredient.ingredient, let measurement = ingredient.measure {
                Text("\(ingredientName): \(measurement)")
            }
        }

    }
}

