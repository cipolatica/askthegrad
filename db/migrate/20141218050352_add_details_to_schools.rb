class AddDetailsToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :rating_average, :float
    add_column :schools, :salary_average, :float
    add_column :schools, :recommend_average, :float
    add_column :schools, :party_average, :float
    add_column :schools, :worth_money_average, :float
    add_column :schools, :debt_average, :float
  end
end
