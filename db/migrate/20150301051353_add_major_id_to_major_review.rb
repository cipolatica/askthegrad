class AddMajorIdToMajorReview < ActiveRecord::Migration
  def change
    add_column :major_reviews, :major_id, :integer
  end
end
