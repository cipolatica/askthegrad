class AddOverallToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :overall_salary, :float
  end
end
