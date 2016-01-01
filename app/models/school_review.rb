class SchoolReview < ActiveRecord::Base
  belongs_to :schools
  has_many :comments
  validates :year_graduated, numericality: {minimum: 2, message: "Please select your graduation year"}
  validates :annual_salary, numericality: {greater_than_or_equal_to: 0, message: "Please enter a valid number for your annual salary - ex 35999"}
  validates :rating, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5, message: "Please enter a number between 0 and 5 for the rating"}
  validates :debt, numericality: {greater_than_or_equal_to: 0, message: "Please enter a valid number for your debt - ex 18999"}
  validates :review, length: { minimum: 1, maximum: 2000, too_short: "Please enter a Major review", too_long: "Your Major review must be less than 2000 characters"}
  validates :school_review, length: { minimum: 1, maximum: 2000, too_short: "Please enter a College review", too_long: "Your College review must be less than 2000 characters"}
  validates :title, length: { maximum: 100, message: "Title must be be less than 100 characters" }
  validates :party_school, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5, message: "Please enter a number between 0 and 5 for the part school rating"}
  validates :difficulty, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5, message: "Please enter a number between 0 and 5 for the difficulty"}
  
  has_reputation :votes, source: :user, aggregated_by: :sum
end
