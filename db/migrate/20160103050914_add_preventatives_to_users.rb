class AddPreventativesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :review_list, :text
    add_column :users, :review_daily_count, :text
    add_column :users, :email_daily_count, :text
  end
end
