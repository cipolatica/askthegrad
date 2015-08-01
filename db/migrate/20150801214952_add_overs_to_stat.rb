class AddOversToStat < ActiveRecord::Migration
  def change
    add_column :stats, :c_overall_sal_names, :text
    add_column :stats, :c_overall_sal_ids, :text
    add_column :stats, :c_overall_sal_amounts, :text
  end
end
