class RemoveMajorListFromSchool < ActiveRecord::Migration
  def change
    remove_column :schools, :top_major_id_1, :integer
    remove_column :schools, :top_major_id_2, :integer
    remove_column :schools, :top_major_id_3, :integer
    remove_column :schools, :top_major_id_4, :integer
    remove_column :schools, :top_major_id_5, :integer
    remove_column :schools, :top_major_name_1, :string
    remove_column :schools, :top_major_name_2, :string
    remove_column :schools, :top_major_name_3, :string
    remove_column :schools, :top_major_name_4, :string
    remove_column :schools, :top_major_name_5, :string
    remove_column :schools, :top_major_amount_1, :float
    remove_column :schools, :top_major_amount_2, :float
    remove_column :schools, :top_major_amount_3, :float
    remove_column :schools, :top_major_amount_4, :float
    remove_column :schools, :top_major_amount_5, :float
  end
end
