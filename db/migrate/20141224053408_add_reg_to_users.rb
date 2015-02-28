class AddRegToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reg, :integer
  end
end
