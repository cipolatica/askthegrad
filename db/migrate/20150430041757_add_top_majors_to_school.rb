class AddTopMajorsToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :top_major_id_1, :integer
    add_column :schools, :top_major_id_2, :integer
    add_column :schools, :top_major_id_3, :integer
    add_column :schools, :top_major_id_4, :integer
    add_column :schools, :top_major_id_5, :integer
    add_column :schools, :top_major_name_1, :string
    add_column :schools, :top_major_name_2, :string
    add_column :schools, :top_major_name_3, :string
    add_column :schools, :top_major_name_4, :string
    add_column :schools, :top_major_name_5, :string
    add_column :schools, :top_major_amount_1, :float
    add_column :schools, :top_major_amount_2, :float
    add_column :schools, :top_major_amount_3, :float
    add_column :schools, :top_major_amount_4, :float
    add_column :schools, :top_major_amount_5, :float
  end
end
