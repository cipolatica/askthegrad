class AddFloatStringsToSchoolReviews < ActiveRecord::Migration
  def change
    add_column :school_reviews, :salary_string, :string
    add_column :school_reviews, :debt_string, :string
  end
end
