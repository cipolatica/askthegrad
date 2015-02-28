class AddCommentIdToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :comment_id, :integer
  end
end
