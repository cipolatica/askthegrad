class AddDiffsToStat < ActiveRecord::Migration
  def change
    add_column :stats, :m_sal_names, :text
    add_column :stats, :m_sal_amounts, :text
    add_column :stats, :m_sal_ids, :text
  end
end
