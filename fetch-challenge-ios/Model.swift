//
//  Model.swift
//  fetch-challenge-ios
//
//  Created by Shivam Nanda on 10/5/23.
//

import Foundation


struct Dessert: Codable, Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
}

struct DessertssResponse: Codable {
    let meals: [Dessert]
}


struct Ingredient: Hashable {
    let ingredient: String?
    let measure: String?
}

struct MealResponse: Codable {
    let meals: [Recipe] 
}

struct Recipe: Codable, Hashable {
    let idMeal: String?
   let strMeal: String?
   let strCategory: String?
   let strArea: String?
   let strInstructions: String
   let strMealThumb: String?
   let strTags: String?
   let strYoutube: String?
   let strIngredient1: String?
   let strIngredient2: String?
   let strIngredient3: String?
   let strIngredient4: String?
   let strIngredient5: String?
   let strIngredient6: String?
   let strIngredient7: String?
   let strIngredient8: String?
   let strIngredient9: String?
   let strIngredient10: String?
   let strIngredient11: String?
   let strIngredient12: String?
   let strIngredient13: String?
   let strIngredient14: String?
   let strIngredient15: String?
   let strIngredient16: String?
   let strIngredient17: String?
   let strIngredient18: String?
   let strIngredient19: String?
   let strIngredient20: String?
   let strMeasure1: String?
   let strMeasure2: String?
   let strMeasure3: String?
   let strMeasure4: String?
   let strMeasure5: String?
   let strMeasure6: String?
   let strMeasure7: String?
   let strMeasure8: String?
   let strMeasure9: String?
   let strMeasure10: String?
   let strMeasure11: String?
   let strMeasure12: String?
   let strMeasure13: String?
   let strMeasure14: String?
   let strMeasure15: String?
   let strMeasure16: String?
   let strMeasure17: String?
   let strMeasure18: String?
   let strMeasure19: String?
   let strMeasure20: String?
   let strSource: String?
   let strImageSource: String?
   let strCreativeCommonsConfirmed: String?
   let dateModified: String?
       
    
    
    var ingredientsAndMeasurements: [Ingredient] {
        var result: [Ingredient] = []
        let mirror = Mirror(reflecting: self)
        
        for i in 1...20 {
            let ingredientKey = "strIngredient\(i)"
            let measureKey = "strMeasure\(i)"
            
            for (label, value) in mirror.children {
                if let label = label, label == ingredientKey,
                   let ingredient = value as? String, !ingredient.isEmpty {
                    
                    // Try to find the corresponding measurement
                    if let measure = mirror.children.first(where: { $0.label == measureKey })?.value as? String, !measure.isEmpty {
                        result.append(Ingredient(ingredient: ingredient, measure: measure))
                    } else {
                        // Handle the case where measurement is null or empty
                        result.append(Ingredient(ingredient: ingredient, measure: "N/A"))
                    }
                }
            }
        }
        
        return result
    }
}
