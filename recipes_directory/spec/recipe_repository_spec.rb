require "recipe_repository"

def reset_Recipes_table
  seed_sql = File.read("spec/recipes_seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "recipes_directory_test" })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do
    reset_Recipes_table
  end

  it "return all recipes" do
    repo = RecipeRepository.new

    recipes = repo.all

    expect(recipes[0].id).to eq "1"
    expect(recipes[0].name).to eq "rice"
    expect(recipes[0].cooking_time).to eq "20"
    expect(recipes[0].rating).to eq "5"

    expect(recipes[1].id).to eq "2"
    expect(recipes[1].name).to eq "pasta"
    expect(recipes[1].cooking_time).to eq "30"
    expect(recipes[1].rating).to eq "4"
  end

  it "returns a single recipe" do
    repo = RecipeRepository.new

    recipe = repo.find(1)

    expect(recipe.id).to eq "1"
    expect(recipe.name).to eq "rice"
    expect(recipe.cooking_time).to eq "20"
    expect(recipe.rating).to eq "5"
  end
end
