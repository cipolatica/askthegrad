class SearchSuggestionsController < ApplicationController
  def index
    school = School.search(params[:term])
    session[:search_index] = school.pluck(:id)
    session[:search_name] = school.pluck(:searchable_name)
    render json: school.pluck(:searchable_name)
    #render json: School.search(params[:term])
  end
end
