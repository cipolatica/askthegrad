class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :login
  validates :reg, numericality: { only_integer: true }, allow_nil: true
  validates :username, :uniqueness => { :case_sensitive => false }, :presence => true
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  #has_reputation :votes, source: {reputation: :votes, of: :school_reviews}, aggregated_by: :sum
end
