class AddSchoolNameToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :school_name, :string
  end
end
