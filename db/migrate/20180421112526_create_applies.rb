class CreateApplies < ActiveRecord::Migration[5.1]
  def change
    create_table :applies do |t|
      t.integer :post_id
      t.integer :user_id
      t.string :state

      t.timestamps
    end
  end
end
