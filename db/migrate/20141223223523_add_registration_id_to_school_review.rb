class AddRegistrationIdToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :registration_id, :string
  end
end
