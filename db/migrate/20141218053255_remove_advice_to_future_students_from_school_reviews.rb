class RemoveAdviceToFutureStudentsFromSchoolReviews < ActiveRecord::Migration
  def change
    remove_column :school_reviews, :advice_to_future_students, :text
  end
end
