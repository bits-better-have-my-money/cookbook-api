class RecipesController < ApplicationController
  def one_recipe
    recipe = Recipe.first
    render json: recipe.as_json
  end
end
