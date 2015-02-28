class AddPartySchoolToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :party_school, :float
  end
end
