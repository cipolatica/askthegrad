class AddCollegeReviewIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :college_review_id, :integer
  end
end
