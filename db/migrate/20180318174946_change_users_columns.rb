class ChangeUsersColumns < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.string :word
      t.string :university
      t.string :campus
      t.text :memo
    end
  end
end
