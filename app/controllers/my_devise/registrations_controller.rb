# app/controllers/registrations_controller.rb
class MyDevise::RegistrationsController < Devise::RegistrationsController
  def new
    @title = "Sign up"
    super
  end

  def create
    super
    if (resource.save && session[:reg_id] != nil)
      resource.reg = session[:reg_id]
      resource.save
    end
    # add custom create logic here
  end

  def update
    super
  end
end 
