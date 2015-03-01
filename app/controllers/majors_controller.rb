class MajorsController < ApplicationController
  def index
    @title = "Majors"
    if session[:search_name] && session[:search_index]
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
      @majors = Major.clickable_search(params[:major_search]).order(:name)
    end
  end
end
