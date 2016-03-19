class CreateUnauthenticatedReviews < ActiveRecord::Migration
  def change
    create_table :unauthenticated_reviews do |t|
      t.integer :school_id
      t.integer :year_graduated
      t.boolean :recommend_this_school
      t.decimal :rating
      t.decimal :annual_salary
      t.boolean :worth_money
      t.float :debt
      t.text :review
      t.string :title
      t.float :party_school
      t.integer :major_id
      t.string :position_title
      t.float :school_rating
      t.float :major_rating
      t.float :difficulty
      t.boolean :recommend_this_major
      t.float :career_satisfaction
      t.boolean :career_relation
      t.string :major_name
      t.string :school_name
      t.text :school_review
      t.float :current_salary

      t.timestamps
    end
  end
end
