class CreateMajorSearchSuggestions < ActiveRecord::Migration
  def change
    create_table :major_search_suggestions do |t|
      t.string :term
      t.integer :popularity

      t.timestamps
    end
  end
end
