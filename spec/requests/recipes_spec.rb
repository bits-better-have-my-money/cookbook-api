require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /recipes" do
    it "should return an array of recipes" do
      user = User.create({name: "Ace", email: "ace@gmail.com", password: "password"})
      Recipe.create!([
        {title: "Empty Sandwich", ingredients: "Two slices of bread", directions: "Place slices of bread next to each other.", prep_time: 72, user_id: user.id},
        {title: "Licorice", ingredients: "Licorice", directions: "Buy licorice from store.", prep_time: 120, user_id: user.id}
      ])
      get "/recipes" # web request that returns web resposne in variable called response
      recipes = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(recipes.length).to eq(2)
    end
  end
  describe "GET /recipes/:id" do
    it "should return a hash with the appropriate attributes" do
      user = User.create({name: "Ace", email: "ace@gmail.com", password: "password"})
      Recipe.create({title: "Empty Sandwich", ingredients: "Two slices of bread", directions: "Place slices of bread next to each other.", prep_time: 72, user_id: user.id})

      get "/recipes/#{Recipe.first.id}"
      recipe = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(recipe["title"]).to eq("Empty Sandwich")
    end
  end
  describe "POST /recipes" do
    it "should create a recipe when a user is logged in and submits valid data" do
      user = User.create({name: "Ace", email: "ace@gmail.com", password: "password"})
      jwt = JWT.encode({user_id: user.id}, Rails.application.credentials.fetch(:secret_key_base),"HS256")

      post "/recipes", 
      params: { 
        title: "New Title", 
        ingredients: "New Ingredients", 
        directions: "New Directions", 
        prep_time: 10
      }, 
      headers: {"Authorization" => "Bearer #{jwt}"}

      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(recipe["title"]).to eq("New Title")
    end
    it "should return a 401 when a user is not logged in (aka no jwt)" do
      post "/recipes", 
      params: {}

      expect(response).to have_http_status(:unauthorized)
    end
    it "should return an error status code with jwt and invalid data" do
      user = User.create({name: "Ace", email: "ace@gmail.com", password: "password"})
      jwt = JWT.encode({user_id: user.id}, Rails.application.credentials.fetch(:secret_key_base),"HS256")

      post "/recipes", 
      params: {}, 
      headers: {"Authorization" => "Bearer #{jwt}"}

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end