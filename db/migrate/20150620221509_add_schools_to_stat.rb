class AddSchoolsToStat < ActiveRecord::Migration
  def change
    add_column :stats, :top_college_party_school_amounts, :text
    add_column :stats, :top_college_party_school_ids, :text
  end
end
