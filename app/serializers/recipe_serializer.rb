class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :chef, :ingredients, :directions, :image_url, :prep_time, :friendly_created_at, :friendly_prep_time
end
