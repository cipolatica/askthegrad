class AddLineageToComment < ActiveRecord::Migration
  def change
    add_column :comments, :lineage, :string
  end
end
