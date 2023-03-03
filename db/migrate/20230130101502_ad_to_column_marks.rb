class AdToColumnMarks < ActiveRecord::Migration[7.0]
  def change
    add_column :marks, :total,   :integer
  end
end
