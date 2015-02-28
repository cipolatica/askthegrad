class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :college_id
      t.integer :major_id
      t.integer :rating

      t.timestamps
    end
  end
end
