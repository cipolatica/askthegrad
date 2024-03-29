class CreateSchoolReviews < ActiveRecord::Migration
  def change
    create_table :school_reviews do |t|
      t.decimal :rating
      t.belongs_to :school
      t.decimal :annual_salary
      t.integer :year_graduated
      t.boolean :recommend_this_school
      t.boolean :party_school
      t.text :pros
      t.text :cons
      t.text :advice_to_future_students

      t.timestamps
    end
  end
end
