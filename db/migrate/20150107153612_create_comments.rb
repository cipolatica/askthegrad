class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :college_id
      t.integer :major_id
      t.integer :counter
      t.text :content
      t.string :username

      t.timestamps
    end
  end
end
