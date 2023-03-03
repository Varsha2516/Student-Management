class AddToColumnSignup < ActiveRecord::Migration[7.0]
  def change
    add_column :signups, :password_reset_token,   :text
    add_column :signups, :password_reset_sent_at,   :datetime
  end
end
