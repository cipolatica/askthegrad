class RemovePartySchoolFromSchoolReview < ActiveRecord::Migration
  def change
    remove_column :school_reviews, :party_school, :float
  end
end
