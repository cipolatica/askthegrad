class AddSearchesToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :searchable_name, :string
    add_column :schools, :popularity, :integer
  end
end
