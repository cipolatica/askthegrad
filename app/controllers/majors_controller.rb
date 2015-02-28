class MajorsController < ApplicationController
  def index
    @title = "Majors"
    @majors = Major.all.order(:name)
  end
end
