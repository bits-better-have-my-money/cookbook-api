class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :ingredients, :directions, :image_url, :prep_time, :friendly_created_at, :friendly_prep_time, :created_at

  attribute :owner
  belongs_to :user

  def owner
    current_user == object.user
  end
end
