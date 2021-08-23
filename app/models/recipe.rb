class Recipe
  attr_accessor :title, :chef, :ingredients, :directions, :prep_time

  def initialize(options)
    @title = options[:title]
    @chef = options[:chef]
    @ingredients = options[:ingredients]
    @directions = options[:directions]
    @prep_time = options[:prep_time]
  end
end

new_recipe = Recipe.new({title: "Raw Eggs", chef: "Jay Wengrow", ingredients: "One live Chicken", directions: "Squeeze the chicken"})