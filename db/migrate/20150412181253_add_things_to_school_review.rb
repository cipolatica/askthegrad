class AddThingsToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :major_id, :integer
    add_column :school_reviews, :position_title, :string
    add_column :school_reviews, :school_rating, :float
    add_column :school_reviews, :major_rating, :float
    add_column :school_reviews, :difficulty, :float
  end
end
