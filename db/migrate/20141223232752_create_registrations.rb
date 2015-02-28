class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :user_id
      t.integer :school_id
      t.integer :school_review_id
      t.integer :major_id
      t.integer :major_review_id

      t.timestamps
    end
  end
end
