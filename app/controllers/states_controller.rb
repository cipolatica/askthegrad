class StatesController < ApplicationController
  def index
    @title = "Choose your State"
    @states = State.all.order(:name)
    session[:school_id_for_major] = nil
  end
end
