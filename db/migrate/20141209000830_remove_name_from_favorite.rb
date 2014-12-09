class RemoveNameFromFavorite < ActiveRecord::Migration
  def change
    remove_column :favorites, :name, :string
  end
end
