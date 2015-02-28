class AddIsParentToComment < ActiveRecord::Migration
  def change
    add_column :comments, :is_parent, :boolean
  end
end
