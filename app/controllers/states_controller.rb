class StatesController < ApplicationController
  def index
    @title = "Choose your State"
    @states = State.all.order(:name)
    session[:school_id_for_major] = nil
    if params[:clr_sch] != nil
      session[:major_id_for_school] = nil
    end
    if params[:major_id] != nil
      session[:major_id_for_school] = params[:major_id]
      flash[:notice] = "Please link your college before reviewing your major."
    end
  end
end
