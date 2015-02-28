class AddRegisterIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :register_id, :integer
  end
end
