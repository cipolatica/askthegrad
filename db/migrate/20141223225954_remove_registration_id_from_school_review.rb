class RemoveRegistrationIdFromSchoolReview < ActiveRecord::Migration
  def change
    remove_column :school_reviews, :registration_id, :string
  end
end
