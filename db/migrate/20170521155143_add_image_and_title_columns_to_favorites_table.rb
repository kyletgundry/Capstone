class AddImageAndTitleColumnsToFavoritesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :favorites, :image, :string
    add_column :favorites, :title, :string
  end
end
