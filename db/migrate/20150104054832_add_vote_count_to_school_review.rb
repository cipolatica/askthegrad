class AddVoteCountToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :vote_count, :integer
  end
end
