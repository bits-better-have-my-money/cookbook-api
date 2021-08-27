class RecipesController < ApplicationController

  def index
    recipes = Recipe.all
    render json: recipes.as_json
  end

  def create
    render json: {message: "Creating a recipe...."}
  end

  def show
    recipe = Recipe.find(params[:id])
    render json: recipe.as_json
  end

end
