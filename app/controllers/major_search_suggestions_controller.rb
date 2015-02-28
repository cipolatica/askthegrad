class MajorSearchSuggestionsController < ApplicationController
  def index
    major = Major.search(params[:term])
    session[:search_index] = major.pluck(:id)
    session[:search_name] = major.pluck(:name)
    render json: major.pluck(:name)
  end
end
