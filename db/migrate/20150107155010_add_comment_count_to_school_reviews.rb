class AddCommentCountToSchoolReviews < ActiveRecord::Migration
  def change
    add_column :school_reviews, :comment_count, :integer
  end
end
