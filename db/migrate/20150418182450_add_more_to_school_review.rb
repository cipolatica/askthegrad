class AddMoreToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :recommend_this_major, :boolean
    add_column :school_reviews, :career_satisfaction, :float
  end
end
