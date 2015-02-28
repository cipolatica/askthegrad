class RemoveConsFromSchoolReviews < ActiveRecord::Migration
  def change
    remove_column :school_reviews, :cons, :text
  end
end
