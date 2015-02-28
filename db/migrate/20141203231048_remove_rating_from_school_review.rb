class RemoveRatingFromSchoolReview < ActiveRecord::Migration
  def change
    remove_column :school_reviews, :rating, :decimal
  end
end
