class AddColumnUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_reset_token,   :text
    add_column :users, :password_reset_token_expire_at,   :datetime
  end
end
