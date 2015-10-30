class AboutController < ApplicationController
  def index
    @title = "About Us"
    session[:school_id_for_major] = nil
    session[:major_id_for_school] = nil
  end
end
