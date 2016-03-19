class RemoveDecimalsFromUnauthenticatedReview < ActiveRecord::Migration
  def change
    remove_column :unauthenticated_reviews, :rating, :decimal
    remove_column :unauthenticated_reviews, :annual_salary, :decimal
  end
end
