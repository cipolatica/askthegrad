class AddUserIdToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :user_id, :integer
  end
end
