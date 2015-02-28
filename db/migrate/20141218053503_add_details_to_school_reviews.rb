class AddDetailsToSchoolReviews < ActiveRecord::Migration
  def change
    add_column :school_reviews, :worth_money, :boolean
    add_column :school_reviews, :debt, :float
    add_column :school_reviews, :review, :text
  end
end
