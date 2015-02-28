class SchoolReview < ActiveRecord::Base
  belongs_to :schools
  has_many :comments
  validates :year_graduated, numericality: {minimum: 2, message: "Please select your graduation year"}
  validates :annual_salary, numericality: {greater_than_or_equal_to: 0, message: "Please enter a valid number for your annual salary"}
  validates :rating, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 10, message: "Please enter a number between 1 and 10 for the rating"}
  validates :debt, numericality: {greater_than_or_equal_to: 0, message: "Please enter a valid number for your debt"}
  validates :review, length: { minimum: 1, maximum: 5000, too_short: "Please enter a review", too_long: "Your review must be less than 5000 characters"}
  validates :title, length: { maximum: 100, message: "Title must be be less than 100 characters" }
  
  has_reputation :votes, source: :user, aggregated_by: :sum
end
