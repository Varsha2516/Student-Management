class AddToColumnMarks < ActiveRecord::Migration[7.0]
  def change
    add_column :marks, :tamil,   :integer
    add_column :marks, :english, :integer
    add_column :marks, :maths,   :integer
    add_column :marks, :science, :integer
    add_column :marks, :social,  :integer
    


  end
end
