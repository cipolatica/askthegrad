class MajorsController < ApplicationController
  def index
    @tab_title = "Majors selection page"
    @meta_description = "This is the Majors Selection page for Ask The Grad. Select a major to rate or view its potential salary."
    @meta_keywords = "ask the grad, ask the grad major selection page, overview, major picker"
    @title = "Choose your Major"
    session[:major_id_for_school] = nil
    if params[:clr_sch] != nil
      cleanup_post_flow
      cleanup_autocomplete_search
      session[:school_id_for_major] = nil
      @majors = Major.all.order(:name)
    elsif params[:school_id] != nil
      session[:school_id_for_major] = params[:school_id]
      @majors = Major.all.order(:name)
      if not is_integer_sql_safe(params[:school_id])
        logger.debug "majors.controller: index: not sql safe"
        return
      end
      @small_text = School.find(params[:school_id]).name
    elsif session[:search_name] && session[:search_index]
      counter = 0
      session[:search_name].each do |s|
        if s == params[:major_search]
          redirect_to major_reviews_path(:major_id => session[:search_index][counter]) and return
        end
        counter += 1
      end
      @majors = Major.clickable_search(params[:major_search]).order(:name)
      if @majors.length == 1
        redirect_to major_reviews_path(:major_id => @majors[0].id)
      elsif @majors.length == 0
        #redirect_to (states_path), :notice => "Couldn't find your major. Search for it here." and return
        #redirect_to (:back), :notice => "problem with the start_date and end_date" and return
        @majors = Major.all.order(:name)
        flash[:notice] = "Couldn't find your major. Search for it here."
      end
    else
      if session[:executing_post_flow] != nil
        @small_text = "Step 3 of 4: " + School.find(session[:executing_post_flow_school]).name
      end
      @majors = Major.clickable_search(params[:major_search]).order(:name)
    end
  end
end
