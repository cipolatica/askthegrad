class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :name
      t.text :top_college_salary_names
      t.text :top_college_salary_amounts
      t.text :top_college_salary_ids
      t.text :top_college_debt_names
      t.text :top_college_debt_amounts
      t.text :top_college_debt_ids
      t.text :top_college_recommend_names
      t.text :top_college_recommend_amounts
      t.text :top_college_recommend_ids
      t.text :top_college_rating_names
      t.text :top_college_rating_amounts
      t.text :top_college_rating_ids
      t.text :top_college_worth_money_names
      t.text :top_college_worth_money_amounts
      t.text :top_college_worth_money_ids
      t.text :top_college_party_school_names
      t.text :top_college_party_amounts
      t.text :top_college_party_ids
      t.text :top_major_rating_names
      t.text :top_major_rating_amounts
      t.text :top_major_rating_ids
      t.text :top_major_difficulty_names
      t.text :top_major_difficulty_amounts
      t.text :top_major_difficulty_ids
      t.text :top_major_recommend_names
      t.text :top_major_recommend_amounts
      t.text :top_major_recommend_ids
      t.text :top_major_salary_names
      t.text :top_major_salary_amounts
      t.text :top_major_salary_ids

      t.timestamps
    end
  end
end
