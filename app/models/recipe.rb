class Recipe < ApplicationRecord
end

recipe = Recipe.new(title: "Ice Cubes", chef: "Dani Zaghian", 
ingredients: "Water", directions: "Place water in freezer", prep_time: 90)