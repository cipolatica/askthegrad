class RemoveProsFromSchoolReviews < ActiveRecord::Migration
  def change
    remove_column :school_reviews, :pros, :text
  end
end
