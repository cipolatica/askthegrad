class AddTopsToMajor < ActiveRecord::Migration
  def change
    add_column :majors, :top_school_ids, :string
    add_column :majors, :top_school_names, :string
    add_column :majors, :top_school_amounts, :string
  end
end
