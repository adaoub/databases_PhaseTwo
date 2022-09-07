require_relative "./lib/database_connection"
require_relative "./lib/recipe_repository"

DatabaseConnection.connect("recipes_directory")

recipe_repository = RecipeRepository.new

result_all = recipe_repository.all

result_find = recipe_repository.find(3)
result_all.each do |recipe|
  puts "#{recipe.id} - #{recipe.name} - #{recipe.cooking_time} - #{recipe.rating}"
end

puts "#{result_find.id} - #{result_find.name} - #{result_find.cooking_time} - #{result_find.rating}"
