class RemoveMoreFromStat < ActiveRecord::Migration
  def change
    remove_column :stats, :money_names, :text
    remove_column :stats, :money_amounts, :text
    remove_column :stats, :money_ids, :text
  end
end
