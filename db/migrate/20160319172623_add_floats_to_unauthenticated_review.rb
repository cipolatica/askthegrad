class AddFloatsToUnauthenticatedReview < ActiveRecord::Migration
  def change
    add_column :unauthenticated_reviews, :rating, :float
    add_column :unauthenticated_reviews, :annual_salary, :float
  end
end
