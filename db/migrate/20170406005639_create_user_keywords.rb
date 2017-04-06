class CreateUserKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :user_keywords do |t|
      t.integer :user_id
      t.integer :keyword_id

      t.timestamps
    end
  end
end
