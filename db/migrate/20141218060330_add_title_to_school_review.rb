class AddTitleToSchoolReview < ActiveRecord::Migration
  def change
    add_column :school_reviews, :title, :string
  end
end
