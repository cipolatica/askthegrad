class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protected
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
      school_review = SchoolReview.find(reg.school_review_id)
      
      school_review.update(register_id: nil, school_id:reg.school_id, user_id:current_user.id)
      school = School.find(reg.school_id)
      if school.college_counter == nil
        school.college_counter = 0
      end
      if school.two_year_college == nil
        school.two_year_college = 0
      end
      if school.recommend_average == nil
        school.recommend_average = 0
      end
      if school.party_average == nil
        school.party_average = 0
      end
      if school.worth_money_average == nil
        school.worth_money_average = 0
      end
      if school.rating_average == nil
        school.rating_average = 0
      end
      if school.salary_average == nil
        school.salary_average = 0
      end
      if school.debt_average == nil
        school.debt_average = 0
      end
      if school.overall_salary == nil
        school.overall_salary = 0
      end
      school.recommend_average = update_bool_average(school_review.recommend_this_school, school.recommend_average, school.college_counter)
      school.party_average = update_num_average(school_review.party_school, school.party_average, school.college_counter)
      school.worth_money_average = update_bool_average(school_review.worth_money, school.worth_money_average, school.college_counter)
      school.rating_average = update_num_average(school_review.rating, school.rating_average, school.college_counter)
      school.overall_salary = update_num_average(school_review.annual_salary, school.overall_salary, school.college_counter)
      if (school_review.year_graduated >= (Date.today.year - 2))
        school.salary_average = update_num_average(school_review.annual_salary, school.salary_average, school.two_year_college)
        school.debt_average = update_num_average(school_review.debt, school.debt_average, school.two_year_college)
        school.two_year_college += 1
      end
      school.college_counter += 1
      school.save
      reg.destroy
      resource.update(reg: nil)
      session[:reg_id] = nil

      school_review_path(school_review.id)
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
