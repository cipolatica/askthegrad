class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protected
  def cleanup_post_flow
    session[:executing_post_flow] = nil
    session[:executing_post_flow_state] = nil
    session[:executing_post_flow_school] = nil
    session[:executing_post_flow_major] = nil
  end
  def cleanup_autocomplete_search
    session[:search_name] = nil
    session[:search_index] = nil
  end

  def update_num_average (the_num, the_average, the_counter)
    return ((the_average * the_counter) + the_num) / (the_counter + 1)
  end
  def update_bool_average (the_bool, the_average, the_counter)
    val = the_bool ? 1 : 0
    return ((the_average * the_counter) + val) / (the_counter + 1)
  end
  def after_sign_in_path_for(resource)
    if (session[:reg_id] == nil)
      root_path
    else
      reg = Registration.find(session[:reg_id])
      session[:reg_id] = nil

      school_review_path(reg.school_id)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :reg) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me, :reg) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  private

  def is_boolean_sql_safe(value)
    if (value == nil)
      return true
    end
    if (value.is_a? String)
      return false
    end
    return true
  end

  def is_integer_sql_safe(value)
    if (value == nil)
      return true
    end
    if (value.to_s =~ /\A[0-9]+\z/)
      return true
    end
    return false
  end

  def is_float_sql_safe(amount)
    if amount == nil
      return true
    end
    amount = amount.to_s.gsub("$","").gsub(",","").gsub(".","").gsub("+","").gsub("-","")
    if (amount =~ /\A[0-9]+\z/)
      return true
    end
    return false
  end

  def make_string_sql_safe(str)
    if (str == nil)
      return ""
    end
    str = str.to_s.gsub("(","[").gsub(")","]").gsub(";",",").gsub("DROP","Drop").gsub("DATABASE","Database").gsub("SELECT","Select").gsub("CREATE","Create")
    str = str.to_s.gsub("ALTER","[").gsub("PASSWORD","Password").gsub("USER","User").gsub("WITH","With").gsub("1=1","").gsub("destroy","desrtoy").gsub("admin","adminn").gsub(" user "," User ")
    return str
  end

  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
  helper_method :mobile_device?
end
