class SchoolsController < ApplicationController
  def index
    @title = "Choose your College"
    if params[:the_state]
      state_id = params[:the_state]
      @schools = School.where(state_id:state_id["state_id"]).order(:name)
    else 
      if session[:search_name] && session[:search_index]
        counter = 0
        session[:search_name].each do |s|
          if s == params[:search]
            redirect_to school_reviews_path(:the_school => { :school_id => session[:search_index][counter] }) and return
          end
          counter += 1
        end
        @schools = School.clickable_search(params[:search]).order(:name)
        if @schools.length == 1
          redirect_to school_reviews_path(:the_school => { :school_id => @schools[0].id })
        elsif @schools.length == 0
          redirect_to (states_path), :notice => "Couldn't find your college. Search by state." and return
          #redirect_to (:back), :notice => "problem with the start_date and end_date" and return
        end
      else
        @schools = School.clickable_search(params[:search]).order(:name)
      end
    end
  end
  def show
  
  end
end
