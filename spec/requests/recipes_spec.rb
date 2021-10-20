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
end