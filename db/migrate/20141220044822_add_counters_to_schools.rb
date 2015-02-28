class AddCountersToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :college_counter, :integer
    add_column :schools, :major_counter, :integer
    add_column :schools, :two_year_college, :integer
    add_column :schools, :two_year_major, :integer
  end
end
