class AddNamesToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :major_name, :string
    add_column :school_reviews, :user_name, :string
  end
end
