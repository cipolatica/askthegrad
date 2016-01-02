class StatsController < ApplicationController
  def index
    @stats = Stat.first #theres only one stat set get the first!
    @title = "Rankings"
    session[:school_id_for_major] = nil
    session[:major_id_for_school] = nil
    cleanup_post_flow
  end
end
