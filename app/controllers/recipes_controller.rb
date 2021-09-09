class RecipesController < ApplicationController

  def index
    if current_user
      recipes = Recipe.all
      render json: recipes
    else
      render json: {message: "You must be logged in to do that."}
    end
  end

  def create
    recipe = Recipe.new(
      title: params[:title], 
      ingredients: params[:ingredients], 
      directions: params[:directions], 
      prep_time: params[:prep_time],
      user_id: current_user.id
    )
    recipe.save
    render json: recipe
  end

  def show
    recipe = Recipe.find(params[:id])
    render json: recipe
  end

  def update
    recipe = Recipe.find(params[:id])
    recipe.title = params[:title] || recipe.title
    recipe.ingredients = params[:ingredients] || recipe.ingredients
    recipe.directions = params[:directions] || recipe.directions
    recipe.prep_time = params[:prep_time] || recipe.prep_time
    recipe.save
    render json: recipe
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.stroy
    render json: {message: "Recipe successfully destroyed"}
  end

end
