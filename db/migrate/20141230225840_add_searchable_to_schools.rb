class AddSearchableToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :searchable, :string
  end
end
