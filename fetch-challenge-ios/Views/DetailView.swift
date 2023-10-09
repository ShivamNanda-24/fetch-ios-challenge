import SwiftUI

/*
 DetailView displays the detials such as dessert image, instructions and ingredeints
 */
struct DetailView: View {
    let dessert: Dessert
    @State private var recipe: Recipe?
    @State private var image: UIImage?
    @State private var isDataLoaded = false

    var body: some View {
        ScrollView {
            VStack {
                Text(dessert.strMeal)
                    .padding()
                    .font(.headline)
                    .underline()
                
                if isDataLoaded {
                    // Display the image and recipe if data is loaded
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                    }
                    
                    if let recipe = recipe {
                        // Display the Instructions and measurements
                        Text("Instructions:")
                            .font(.headline)
                            .padding()
                            .underline()
                        
                        ForEach(recipe.strInstructions.split(separator: "."), id: \.self) { instruction in
                            Text(instruction.trimmingCharacters(in: .whitespacesAndNewlines) + ".")
                                .padding(.vertical, 5)
                                .padding(.horizontal, 20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        Text("Measurements:")
                            .font(.headline)
                            .padding()
                            .underline()
            
                        // Displays the mesaurements in the ingredientsView
                        IngredeintsView(recipe: recipe)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                    }
                } else {
                    // Show a loading message while data is being loaded
                    Text("Loading...")
                        .padding()
                }
            }
        }
        .navigationBarTitle("Dessert Details")
        .onAppear {
            // Load the image and recipe asynchronously
            fetchMealDetails(with: dessert.idMeal) { item in
                self.recipe = item
                self.isDataLoaded = true
            }
            
            if let imageUrl = URL(string: dessert.strMealThumb) {
                loadImage(from: imageUrl) { loadedImage in
                    self.image = loadedImage
                    self.isDataLoaded = true
                }
            }
        }
    }
    
    // loads the image with URLSession asynchronously
    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
