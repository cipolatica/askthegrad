class StatesController < ApplicationController
  def index
    @title = "Choose your State"
    @states = State.all.order(:name)
  end
end
