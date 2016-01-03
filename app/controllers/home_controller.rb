class HomeController < ApplicationController
  def index
    session[:school_id_for_major] = nil
    session[:major_id_for_school] = nil
    cleanup_post_flow
    cleanup_autocomplete_search
    if user_signed_in?
      #redirect_to :controller => 'states', :action => 'index'
    end
  end
end
