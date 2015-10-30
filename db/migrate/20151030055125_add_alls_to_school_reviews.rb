class AddAllsToSchoolReviews < ActiveRecord::Migration
  def change
    add_column :school_reviews, :school_review, :text
    add_column :school_reviews, :current_salary, :float
  end
end
