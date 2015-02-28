class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.belongs_to :state
      t.string :name
      t.string :acronym
      t.string :city

      t.timestamps
    end
  end
end
