class AddCurrentSalaryStringToSchoolReviews < ActiveRecord::Migration
  def change
    add_column :school_reviews, :current_salary_string, :string
  end
end
