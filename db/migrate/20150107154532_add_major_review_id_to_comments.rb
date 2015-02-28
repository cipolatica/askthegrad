class AddMajorReviewIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :major_review_id, :integer
  end
end
