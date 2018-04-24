class ChangeApplysColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :applies, :post_user_id, :integer
  end
end
