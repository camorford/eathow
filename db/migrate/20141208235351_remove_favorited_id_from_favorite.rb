class RemoveFavoritedIdFromFavorite < ActiveRecord::Migration
  def change
    remove_column :favorites, :favorited_id, :integer
  end
end
