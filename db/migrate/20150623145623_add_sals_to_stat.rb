class AddSalsToStat < ActiveRecord::Migration
  def change
    add_column :stats, :m_diff_names, :text
    add_column :stats, :m_diff_amounts, :text
    add_column :stats, :m_diff_ids, :text
    add_column :stats, :m_rec_names, :text
    add_column :stats, :m_rec_amounts, :text
    add_column :stats, :m_rec_ids, :text
  end
end
