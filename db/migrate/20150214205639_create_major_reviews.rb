class CreateMajorReviews < ActiveRecord::Migration
  def change
    create_table :major_reviews do |t|
      t.integer :school_id
      t.integer :year_graduated
      t.boolean :recommend_this_major
      t.float :difficulty
      t.float :rating
      t.float :annual_salary
      t.integer :user_id
      t.boolean :worth_money
      t.float :debt
      t.text :review
      t.string :title
      t.string :position_title
      t.integer :register_id
      t.integer :vote_count
      t.integer :comment_count

      t.timestamps
    end
  end
end
