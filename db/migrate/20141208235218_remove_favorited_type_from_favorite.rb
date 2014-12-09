class RemoveFavoritedTypeFromFavorite < ActiveRecord::Migration
  def change
    remove_column :favorites, :favorited_type, :string
  end
end
