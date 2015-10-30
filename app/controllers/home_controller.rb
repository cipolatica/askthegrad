class HomeController < ApplicationController
  def index
    session[:school_id_for_major] = nil
    session[:major_id_for_school] = nil
    if user_signed_in?
      #redirect_to :controller => 'states', :action => 'index'
    end
  end
end
