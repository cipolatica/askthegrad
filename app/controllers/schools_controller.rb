class SchoolsController < ApplicationController
  def index
    @tab_title = "College selection page"
    @meta_description = "This is the College Selection page for Ask The Grad. Select a college to rate or view its potential salary."
    @meta_keywords = "ask the grad, ask the grad college selection page, overview, college picker"
    flash[:notice] = nil # forcing this to be be nil because it displays flash from States page for some reason
    @title = "Choose your College"
    session[:school_id_for_major] = nil
    if params[:the_state]
      state_id = params[:the_state]
      @schools = School.where(state_id:state_id["state_id"]).order(:name)
      @small_text = State.find(state_id["state_id"].to_i).name

      #Save the state in session if we are in the post_flow
      if session[:executing_post_flow] != nil
        session[:executing_post_flow_state] = state_id["state_id"].to_i
        @small_text = "Step 2 of 4: " + @small_text
      end
    else
      if session[:search_name] && session[:search_index]
        counter = 0
        session[:search_name].each do |s|
          if s == params[:search]
            redirect_to school_reviews_path(:the_school => { :school_id => session[:search_index][counter] }) and return
          end
          counter += 1
        end
        counter = 0
        session[:search_name].each do |s|
          if s == params[:find_college]
            redirect_to school_reviews_path(:the_school => { :school_id => session[:search_index][counter] }) and return
          end
          counter += 1
        end
        if params[:search] != nil
          @schools = School.clickable_search(params[:search]).order(:name)
          logger.debug "blah:params[:search] != nil: #{@schools.inspect}"
        else
          @schools = School.clickable_search(params[:find_college]).order(:name)
          logger.debug "blah:params[:search] == nil: #{@schools.inspect}"
          logger.debug "blah:params[:find_college]: #{params[:find_college].inspect}"
        end
        if @schools.length == 1
          redirect_to school_reviews_path(:the_school => { :school_id => @schools[0].id })
        elsif @schools.length == 0
          redirect_to (states_path), :notice => "Couldn't find your college. Search by state." and return
          #redirect_to (:back), :notice => "problem with the start_date and end_date" and return
        end
      else
        if params[:search] != nil
          @schools = School.clickable_search(params[:search]).order(:name)
        else
          @schools = School.clickable_search(params[:find_college]).order(:name)
        end
      end
    end
  end
  def show
  
  end
end
