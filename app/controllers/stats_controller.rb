class StatsController < ApplicationController
  def index
    @stats = Stat.first #theres only one stat set get the first!
    @title = "Stats"
    session[:school_id_for_major] = nil
  end
end
