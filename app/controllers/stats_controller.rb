class StatsController < ApplicationController
  def index
    @stats = Stat.first #theres only one stat set get the first!
    @title = "Stats"
  end
end
