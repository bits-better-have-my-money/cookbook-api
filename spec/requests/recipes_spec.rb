require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /recipes" do
    it "should return an array of recipes" do
      get "/recipes" # web request that returns web resposne in variable called response
      expect(response).to have_http_status(200)
    end
  end
end
