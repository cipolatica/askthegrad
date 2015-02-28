class RemoveAnnualSalaryFromSchoolReview < ActiveRecord::Migration
  def change
    remove_column :school_reviews, :annual_salary, :decimal
  end
end
