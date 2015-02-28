class VotesController < ApplicationController
  def index
  end
  def create
    if user_signed_in? 
      current_vote = Vote.where()
  end
end
