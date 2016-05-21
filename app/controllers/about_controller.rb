class AboutController < ApplicationController
  def index
    @title = "About Us"
    @tab_title = "Linking salaries to college majors"
    @meta_description = "This is the About Us page for Ask The Grad. Learn how we link salaries to college majors."
    @meta_keywords = "ask the grad, ask the grad about us, information"
    session[:school_id_for_major] = nil
    session[:major_id_for_school] = nil
  end
end
