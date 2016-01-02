class StatesController < ApplicationController
  def index
    @title = "Choose your State"
    @states = State.all.order(:name)
    session[:school_id_for_major] = nil
    if params[:post_flow] != nil
      session[:major_id_for_school] = nil
      if user_signed_in?
        session[:executing_post_flow] = "true"
      else
        flash[:alert] = "You need to sign in or sign up before continuing."
        redirect_to new_user_session_path and return
      end
    end
    if params[:clr_sch] != nil
      cleanup_post_flow
      session[:major_id_for_school] = nil
    end
    if params[:major_id] != nil
      session[:major_id_for_school] = params[:major_id]
      #flash[:notice] = "Please link your college before reviewing your major."
    end
  end
end
