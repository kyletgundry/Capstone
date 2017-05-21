class AddImageUrlColumnToSourceTable < ActiveRecord::Migration[5.0]
  def change
    add_column :sources, :image, :string
  end
end
