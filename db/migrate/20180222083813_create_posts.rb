class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :image_name
      t.string :text_title
      t.text :text_about
      t.string :subject
      t.string :condition
      t.integer :price
      t.string :place

      t.timestamps
    end
  end
end
