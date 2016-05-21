class HomeController < ApplicationController
  def index
    @tab_title = "College Reviews, Major Reviews, Salaries by College, Salaries by Major"
    @meta_description = "Ask The Grad is a great place where college graduates can review their college, major, and starting salary after graduation."
    @meta_keywords = "ask the grad, ask the grad home page, education, college, college major, college review, major review, salary by major, college salaries, salary from major, salaries based on major, graduates, alumni, entry level, jobs, schools"
    session[:school_id_for_major] = nil
    session[:major_id_for_school] = nil
    session[:reg_id] = nil
    cleanup_post_flow
    cleanup_autocomplete_search
    if user_signed_in?
      #redirect_to :controller => 'states', :action => 'index'
    end
  end
end
