class StatesController < ApplicationController
  def index
    @title = "States"
    @states = State.all.order(:name)
  end
end
