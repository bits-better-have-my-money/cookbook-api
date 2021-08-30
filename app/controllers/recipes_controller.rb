class RecipesController < ApplicationController

  def index
    recipes = Recipe.all
    render json: recipes.as_json
  end

  def create
    recipe = Recipe.new(
      title: params[:title], 
      chef: params[:chef], 
      ingredients: params[:ingredients], 
      directions: params[:directions], 
      prep_time: params[:prep_time]
    )
    recipe.save
    render json: recipe.as_json
  end

  def show
    recipe = Recipe.find(params[:id])
    render json: recipe.as_json({methods: [:ingredients_list, :directions_list, :friendly_created_at, :friendly_prep_time]})
  end

  def update
    recipe = Recipe.find(params[:id])
    recipe.title = params[:title] || recipe.title
    recipe.chef = params[:chef] || recipe.chef
    recipe.ingredients = params[:ingredients] || recipe.ingredients
    recipe.directions = params[:directions] || recipe.directions
    recipe.prep_time = params[:prep_time] || recipe.prep_time
    recipe.save
    render json: recipe.as_json
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.stroy
    render json: {message: "Recipe successfully destroyed"}
  end

end
