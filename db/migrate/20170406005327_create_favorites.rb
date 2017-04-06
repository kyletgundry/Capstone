class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.integer :source_id
      t.string :url

      t.timestamps
    end
  end
end
