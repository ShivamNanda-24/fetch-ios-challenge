//
//  Backend.swift
//  fetch-challenge-ios
//
//  Created by Shivam Nanda on 10/5/23.
//
import Foundation

var recipe = [Recipe]()

/*
    Fetches desserts of type Desert from the API and decodes the response.
 */
func fetchDesserts(completion: @escaping (Result<[Dessert], Error>) -> Void) {
    guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(NSError(domain: "Data is nil", code: 0, userInfo: nil)))
            return
        }

        do {
            let mealsResponse = try JSONDecoder().decode(DessertssResponse.self, from: data)
            completion(.success(mealsResponse.meals))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}


/*
    Fetches desserts of type Desert from the API and decodes the response.
 */
func fetchMealDetails(with id: String, completion: @escaping (Recipe?) -> Void) {
    guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(MealResponse.self, from: data)
                if let recipe = result.meals.first { // Get the first Recipe object from the array
        
                    completion(recipe)
                } else {
                    completion(nil)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil) // Notify completion with nil in case of an error
            }
        } else {
            // Handle the case where data is nil
            completion(nil)
        }
    }.resume()
}
