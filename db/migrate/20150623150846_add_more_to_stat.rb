class AddMoreToStat < ActiveRecord::Migration
  def change
    add_column :stats, :money_names, :text
    add_column :stats, :money_amounts, :text
    add_column :stats, :money_ids, :text
  end
end
