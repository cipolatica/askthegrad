class AddFalsesToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :rating_f, :string
    add_column :school_reviews, :difficulty_f, :string
    add_column :school_reviews, :party_school_f, :string
  end
end
