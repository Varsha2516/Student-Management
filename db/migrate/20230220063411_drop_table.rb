class DropTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :uses
    drop_table :admin_users
    drop_table :admins
    

  end
end
