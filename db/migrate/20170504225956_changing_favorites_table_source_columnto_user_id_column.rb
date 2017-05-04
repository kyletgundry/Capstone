class ChangingFavoritesTableSourceColumntoUserIdColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :favorites, :source_id, :user_id
  end
end
