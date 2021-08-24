Rails.application.routes.draw do
  get "/one_recipe", controller: "recipes", action: "one_recipe"
end
