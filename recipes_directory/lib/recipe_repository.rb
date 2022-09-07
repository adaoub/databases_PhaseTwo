require "./lib/recipe"

class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    query = "SELECT id, name, cooking_time, rating FROM recipes"
    result = DatabaseConnection.exec_params(query, [])
    recipes_array = []
    result.each do |recipes|
      recipe = Recipe.new
      recipe.id = recipes["id"]
      recipe.name = recipes["name"]
      recipe.cooking_time = recipes["cooking_time"]
      recipe.rating = recipes["rating"]
      recipes_array << recipe
    end

    return recipes_array
    # Returns an array of recipe objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    params = [id]

    # Executes the SQL query:
    query = "SELECT id, name, cooking_time, rating FROM recipes WHERE id = $1"
    result = DatabaseConnection.exec_params(query, params)

    result.each do |recipes|
      @recipe = Recipe.new
      @recipe.id = recipes["id"]
      @recipe.name = recipes["name"]
      @recipe.cooking_time = recipes["cooking_time"]
      @recipe.rating = recipes["rating"]
    end

    return @recipe
    # Returns a single recipe object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(recipe)
  # end

  # def update(recipe)
  # end

  # def delete(recipe)
  # end
end
