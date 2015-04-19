class AddCareerRelationToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :career_relation, :boolean
  end
end
