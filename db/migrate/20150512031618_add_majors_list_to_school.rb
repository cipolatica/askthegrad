class AddMajorsListToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :top_major_ids, :string
    add_column :schools, :top_major_names, :string
    add_column :schools, :top_major_amounts, :string
  end
end
