class AddAnnualSalaryToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :annual_salary, :float
  end
end
