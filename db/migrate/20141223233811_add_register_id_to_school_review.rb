class AddRegisterIdToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :register_id, :integer
  end
end
