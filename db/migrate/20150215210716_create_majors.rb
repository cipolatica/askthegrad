class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.integer :state_id
      t.string :name
      t.string :city
      t.float :rating_average
      t.float :salary_average
      t.float :recommend_average
      t.float :difficulty_average
      t.float :worth_money_average
      t.float :debt_average
      t.float :college_counter
      t.float :major_counter
      t.float :two_year_college
      t.float :two_year_major
      t.string :searchable
      t.string :searchable_name
      t.integer :popularity

      t.timestamps
    end
  end
end
