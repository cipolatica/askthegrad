class AuthenticationRequiredController < ApplicationController
  def index
    @title = "Authentication Required"
    @reg = Registration.find(session[:reg_id])
  end
end
