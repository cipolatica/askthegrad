class AddCommIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :comm_id, :integer
  end
end
