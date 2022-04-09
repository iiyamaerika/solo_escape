class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.integer :user_id, null: false
      t.string :image
      t.text :text, null: false
      t.integer :status,null: false

      t.timestamps
    end
  end
end
