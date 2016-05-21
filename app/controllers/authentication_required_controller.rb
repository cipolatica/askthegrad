class AuthenticationRequiredController < ApplicationController
  def index
    @title = "Authentication Required"
    @tab_title = "Only signed in users can post reviews"
  end
end
