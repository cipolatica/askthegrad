class AddRatingToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :rating, :float
  end
end
