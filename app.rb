require("bundler/setup")
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  erb(:index)
end

get('/recipes/new') do
  @ingredients = Ingredient.all()
  erb(:recipe_form)
end

post('/ingredients') do
  ingredient_name = params.fetch('ingredient_name')
  Ingredient.create({:name => ingredient_name})
  redirect back
end

post('/recipes') do
  recipe_name = params.fetch('recipe_name')
  ingredient_ids = params.fetch('ingredient_ids')
  instructions = params.fetch('instructions')
  @recipe = Recipe.create({:name => recipe_name, :ingredient_ids => ingredient_ids, :instruction => instructions})
  redirect('/recipes/'.concat(@recipe.id().to_s()))
end

get('/recipes/:id') do
  @recipe = Recipe.find(params.fetch('id').to_i())
  erb(:recipe)
end

get('/recipes') do
  @recipes = Recipe.all()
  erb(:recipes)
end
