class AddAlltimeToMajors < ActiveRecord::Migration
  def change
    add_column :majors, :overall_salary, :float
  end
end
