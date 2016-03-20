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
    logger.debug "this is after signin"
    should_navigate_to_root = false

    if (Registration.where(user_id:resource.id).exists? || session[:reg_id] != nil)

      reg = nil

      if Registration.where(user_id:resource.id).exists?
        reg = Registration.where(user_id:resource.id)[0]
      else
        reg = Registration.find(session[:reg_id])
      end

      #reg = Registration.where(user_id:resource.id).exists? ? Registration.where(user_id:resource.id) : Registration.find(session[:reg_id]);
      session[:reg_id] = nil
      unauth_review = UnauthenticatedReview.find(reg.school_review_id)

      authenticated_review = SchoolReview.new
      authenticated_review.school_id = unauth_review.school_id
      authenticated_review.year_graduated = unauth_review.year_graduated
      authenticated_review.recommend_this_school = unauth_review.recommend_this_school
      authenticated_review.rating = unauth_review.rating
      authenticated_review.annual_salary = unauth_review.annual_salary
      authenticated_review.worth_money = unauth_review.worth_money
      authenticated_review.debt = unauth_review.debt
      authenticated_review.review = unauth_review.review
      authenticated_review.title = unauth_review.title
      authenticated_review.party_school = unauth_review.party_school
      authenticated_review.major_id = unauth_review.major_id
      authenticated_review.position_title = unauth_review.position_title
      authenticated_review.school_rating = unauth_review.school_rating
      authenticated_review.major_rating = unauth_review.major_rating
      authenticated_review.difficulty = unauth_review.difficulty
      authenticated_review.recommend_this_major = unauth_review.recommend_this_major
      authenticated_review.career_satisfaction = unauth_review.career_satisfaction
      authenticated_review.career_relation = unauth_review.career_relation
      authenticated_review.major_name = unauth_review.major_name
      authenticated_review.school_name = unauth_review.school_name
      authenticated_review.school_review = unauth_review.school_review
      authenticated_review.current_salary = unauth_review.current_salary
      authenticated_review.user_id = current_user.id
      authenticated_review.user_name = current_user.username

      the_current_user = User.find(current_user.id)
      if did_user_hit_review_limit_max(the_current_user.review_daily_count)
        should_navigate_to_root = true
        reg.destroy
        unauth_review.destroy
        flash[:alert] = "Error: You've made too many reviews today. Try again tomorrow."
      end
      review_daily_count = update_review_daily_count_max(the_current_user.review_daily_count)
      if is_duplicate_review_max(the_current_user.review_list, authenticated_review.school_id, authenticated_review.major_id)
        should_navigate_to_root = true
        reg.destroy
        unauth_review.destroy
        flash[:alert] = "Error: You have already reviewed this college and major."
      end

      if not should_navigate_to_root
        str = update_review_list_max(the_current_user.review_list, authenticated_review.school_id, authenticated_review.major_id)
      end

      if (!should_navigate_to_root && authenticated_review.save)
        unauth_review.destroy
        the_current_user.update(review_list:nil, review_daily_count:nil)
        the_current_user.update(review_list:str, review_daily_count:review_daily_count)
        school = School.find(authenticated_review.school_id)
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

        major = Major.find(authenticated_review.major_id)
        if major.difficulty_average == nil
          major.difficulty_average = 0
        end
        if major.recommend_average == nil
          major.recommend_average = 0
        end
        if major.salary_average == nil
          major.salary_average = 0
        end
        if major.major_counter == nil
          major.major_counter = 0
        end
        if major.two_year_major == nil
          major.two_year_major = 0
        end
        if major.overall_salary == nil
          major.overall_salary = 0
        end
        school.recommend_average = update_bool_average(authenticated_review.recommend_this_school, school.recommend_average, school.college_counter)
        school.party_average = update_num_average(authenticated_review.party_school, school.party_average, school.college_counter)
        school.worth_money_average = update_bool_average(authenticated_review.worth_money, school.worth_money_average, school.college_counter)
        school.rating_average = update_num_average(authenticated_review.rating, school.rating_average, school.college_counter)
        school.debt_average = update_num_average(authenticated_review.debt, school.debt_average, school.college_counter)
        school.overall_salary = update_num_average(authenticated_review.annual_salary, school.overall_salary, school.college_counter)

        major.overall_salary = update_num_average(authenticated_review.annual_salary, major.overall_salary, major.major_counter)
        major.difficulty_average = update_num_average(authenticated_review.difficulty, major.difficulty_average, major.major_counter)
        major.recommend_average = update_bool_average(authenticated_review.recommend_this_major, major.recommend_average, major.major_counter)
        if (authenticated_review.year_graduated >= (Date.today.year - 2))
          major.salary_average = update_num_average(authenticated_review.annual_salary, major.salary_average, major.two_year_major)
          major.two_year_major += 1
          # Find top 5 highest paying majors
          review_list = SchoolReview.where(major_id:major.id, year_graduated:(Date.today.year - 2)..Date.today.year).order(:school_id)
          major.top_school_ids = "^^^^"
          major.top_school_amounts = "^^^^"
          salary_average = 0.0
          current_school_id = review_list[0].school_id
          current_school_counter = 0
          review_list.each do |r|
            if r.school_id != current_school_id
              salary_average = salary_average / current_school_counter
              if does_top_major_list_need_update(salary_average, major.top_school_amounts) #this method should be called does_list_need_update
                major.top_school_ids, major.top_school_amounts = update_top_majors(major.top_school_ids, major.top_school_amounts, salary_average,current_school_id)
              end
              salary_average = 0.0
              current_school_id = r.school_id
              current_school_counter = 0
            end
            salary_average = salary_average + r.annual_salary
            current_school_counter = current_school_counter + 1
          end
          salary_average = salary_average / current_school_counter
          if does_top_major_list_need_update(salary_average, major.top_school_amounts)
            major.top_school_ids, major.top_school_amounts = update_top_majors(major.top_school_ids, major.top_school_amounts, salary_average,current_school_id)
          end
          major.top_school_names = update_top_school_names(major.top_school_ids)
          # DONE with Finding top 5 highest paying Majors

          school.salary_average = update_num_average(authenticated_review.annual_salary, school.salary_average, school.two_year_college)

          school.two_year_college += 1
          # Find top 5 highest paying colleges
          review_list = SchoolReview.where(school_id:authenticated_review.school_id, year_graduated:(Date.today.year - 2)..Date.today.year).order(:major_id)
          school.top_major_ids = "^^^^"
          school.top_major_amounts = "^^^^"
          salary_average = 0.0
          current_major_id = review_list[0].major_id
          current_major_counter = 0
          review_list.each do |r|
            if r.major_id != current_major_id
              salary_average = salary_average / current_major_counter
              if does_top_major_list_need_update(salary_average, school.top_major_amounts)
                school.top_major_ids, school.top_major_amounts = update_top_majors(school.top_major_ids, school.top_major_amounts, salary_average,current_major_id)
              end
              salary_average = 0.0
              current_major_id = r.major_id
              current_major_counter = 0
            end
            salary_average = salary_average + r.annual_salary
            current_major_counter = current_major_counter + 1
          end
          salary_average = salary_average / current_major_counter
          if does_top_major_list_need_update(salary_average, school.top_major_amounts)
            school.top_major_ids, school.top_major_amounts = update_top_majors(school.top_major_ids, school.top_major_amounts, salary_average,current_major_id)
          end
          school.top_major_names = update_top_major_names(school.top_major_ids)
          # DONE with Finding top 5 highest paying colleges
        end
        major.major_counter += 1
        major.save

        school.college_counter += 1
        school.save

        # Update the STATS
        limit_amount = 50
        stats = Stat.first # there is only one stat object, just grabbing the first one

        # update Top College party
        stats.top_college_party_school_names = ""
        stats.top_college_party_school_amounts = ""
        stats.top_college_party_school_ids = ""
        schools = School.where(party_average:1..5).order(party_average: :desc).limit(limit_amount)
        schools.each do |school|
          logger.debug "in the IF man"
          stats.top_college_party_school_names.concat(school.name + "^")
          stats.top_college_party_school_amounts.concat(school.party_average.to_s + "^")
          stats.top_college_party_school_ids.concat(school.id.to_s + "^")
        end
        #logger.debug "stats.top_college_party_school_names: #{stats.top_college_party_school_names.inspect}"

        stats.save # going to save here because i had issues with updating Parties list.. this might now be needed anymore
        stats = Stat.first
        # update Top College Salaries

        stats.top_college_salary_names = ""
        stats.top_college_salary_amounts = ""
        stats.top_college_salary_ids = ""
        schools = School.where(salary_average:100..1000001).order(salary_average: :desc).limit(limit_amount)
        schools.each do |school|
          stats.top_college_salary_names.concat(school.name + "^")
          stats.top_college_salary_amounts.concat(school.salary_average.to_s + "^")
          stats.top_college_salary_ids.concat(school.id.to_s + "^")
        end

        # update overall college salaries
        stats.c_overall_sal_names = ""
        stats.c_overall_sal_amounts = ""
        stats.c_overall_sal_ids = ""
        schools = School.where(overall_salary:100..1000001).order(overall_salary: :desc).limit(limit_amount)
        schools.each do |school|
          stats.c_overall_sal_names.concat(school.name + "^")
          stats.c_overall_sal_amounts.concat(school.overall_salary.to_s + "^")
          stats.c_overall_sal_ids.concat(school.id.to_s + "^")
        end

        # update Top College Debt
        stats.top_college_debt_names = ""
        stats.top_college_debt_amounts = ""
        stats.top_college_debt_ids = ""
        schools = School.where(debt_average:1..1000001).order(debt_average: :desc).limit(limit_amount)
        schools.each do |school|
          stats.top_college_debt_names.concat(school.name + "^")
          stats.top_college_debt_amounts.concat(school.debt_average.to_s + "^")
          stats.top_college_debt_ids.concat(school.id.to_s + "^")
        end

        # update Top College Recommend
        stats.top_college_recommend_names = ""
        stats.top_college_recommend_amounts = ""
        stats.top_college_recommend_ids = ""
        schools = School.where(recommend_average:0.1..1.0).order(recommend_average: :desc).limit(limit_amount)
        schools.each do |school|
          stats.top_college_recommend_names.concat(school.name + "^")
          stats.top_college_recommend_amounts.concat(school.recommend_average.to_s + "^")
          stats.top_college_recommend_ids.concat(school.id.to_s + "^")
        end

        # update Top College Rating
        stats.top_college_rating_names = ""
        stats.top_college_rating_amounts = ""
        stats.top_college_rating_ids = ""
        schools = School.where(rating_average:1..5).order(rating_average: :desc).limit(limit_amount)
        schools.each do |school|
          stats.top_college_rating_names.concat(school.name + "^")
          stats.top_college_rating_amounts.concat(school.rating_average.to_s + "^")
          stats.top_college_rating_ids.concat(school.id.to_s + "^")
        end

        # update Top College Worth Money
        stats.top_college_worth_money_names = ""
        stats.top_college_worth_money_amounts = ""
        stats.top_college_worth_money_ids = ""
        schools = School.where(worth_money_average:0.1..1.0).order(worth_money_average: :desc).limit(limit_amount)
        schools.each do |school|
          stats.top_college_worth_money_names.concat(school.name + "^")
          stats.top_college_worth_money_amounts.concat(school.worth_money_average.to_s + "^")
          stats.top_college_worth_money_ids.concat(school.id.to_s + "^")
        end

        stats.save # going to save here because i had issues with updating lists.. this might now be needed anymore
        stats = Stat.first

        # update Top Major Salaries
        stats.m_sal_names = ""
        stats.m_sal_amounts = ""
        stats.m_sal_ids = ""
        majors = Major.where(salary_average:100..1000001).order(salary_average: :desc).limit(limit_amount)
        majors.each do |major|
          stats.m_sal_names.concat(major.name + "^")
          stats.m_sal_amounts.concat(major.salary_average.to_s + "^")
          stats.m_sal_ids.concat(major.id.to_s + "^")
        end
        #stats.update(top_major_salary_names:stats.top_major_salary_names, top_major_salary_amounts:stats.top_major_salary_amounts, top_major_salary_ids:stats.top_major_salary_ids)
        #logger.debug "stats.top_major_salary_names: #{stats.top_major_salary_names.inspect}"

        # update overall Major Salaries
        stats.m_overall_sal_names = ""
        stats.m_overall_sal_amounts = ""
        stats.m_overall_sal_ids = ""
        majors = Major.where(overall_salary:100..1000001).order(overall_salary: :desc).limit(limit_amount)
        majors.each do |major|
          stats.m_overall_sal_names.concat(major.name + "^")
          stats.m_overall_sal_amounts.concat(major.overall_salary.to_s + "^")
          stats.m_overall_sal_ids.concat(major.id.to_s + "^")
        end

        # update Top Major difficulty
        stats.m_diff_names = ""
        stats.m_diff_amounts = ""
        stats.m_diff_ids = ""
        majors = Major.where(difficulty_average:1..5).order(difficulty_average: :desc).limit(limit_amount)
        majors.each do |major|
          stats.m_diff_names.concat(major.name + "^")
          stats.m_diff_amounts.concat(major.difficulty_average.to_s + "^")
          stats.m_diff_ids.concat(major.id.to_s + "^")
        end

        # update Top Major recommend
        stats.m_rec_names = ""
        stats.m_rec_amounts = ""
        stats.m_rec_ids = ""
        majors = Major.where(recommend_average:0.1..1.0).order(recommend_average: :desc).limit(limit_amount)
        majors.each do |major|
          stats.m_rec_names.concat(major.name + "^")
          stats.m_rec_amounts.concat(major.recommend_average.to_s + "^")
          stats.m_rec_ids.concat(major.id.to_s + "^")
        end

        stats.save
        # DONE Updating STATS

        reg.destroy

        school_review_path(authenticated_review)
      else
        if not should_navigate_to_root
          flash[:alert] = "Error: We were unable to save your review."
        end
        root_path
      end
    else
      root_path

    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :reg) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me, :reg) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  private

  def did_user_hit_email_limit(user_id)
    the_user = User.find(user_id)
    if (the_user.email_daily_count == nil || the_user.email_daily_count.length < 1)
      return false
    end
    email_limit_array = the_user.email_daily_count.split("^")
    if (email_limit_array[0].to_s == Date.today.to_s && email_limit_array.length > 5)
      return true
    end
    return false
  end
  def update_email_count(user_id)
    the_user = User.find(user_id)
    if (the_user.email_daily_count == nil || the_user.email_daily_count.length < 1)
      the_user.email_daily_count = Date.today.to_s
    else
      email_limit_array = the_user.email_daily_count.split("^")
      if email_limit_array[0].to_s != Date.today.to_s
        the_user.email_daily_count = Date.today.to_s
      else
        the_user.email_daily_count.concat(Date.today.to_s)
      end
    end
    the_user.email_daily_count.concat("^")
    return the_user.email_daily_count
  end
  def create_delimiter(limit)
    delimiter = ""
    for i in 1..limit
      delimiter.concat("^")
    end
    return delimiter
  end

  def update_top_school_names(top_school_ids)
    ids_array = top_school_ids.split("^")
    top_school_ids = ""
    for i in 0..4
      if ids_array[i].to_s == nil || ids_array[i].to_s == ""
        top_school_ids.concat("")
      else
        top_school_ids.concat(School.find(ids_array[i].to_i).name)
      end
      if i != 4
        top_school_ids.concat("^")
      end
    end
    return top_school_ids
  end

  def update_top_major_names(top_major_ids)
    ids_array = top_major_ids.split("^")
    top_major_ids = ""
    for i in 0..4
      if ids_array[i].to_s == nil || ids_array[i].to_s == ""
        top_major_ids.concat("")
      else
        top_major_ids.concat(Major.find(ids_array[i].to_i).name)
      end
      if i != 4
        top_major_ids.concat("^")
      end
    end
    return top_major_ids
  end

  def swap_value (value1, value2)
    return value2, value1
  end

  def update_top_majors(top_major_ids, top_major_amounts, salary_average, current_major_id)
    amounts_array = top_major_amounts.split("^")
    ids_array = top_major_ids.split("^")
    for index in (4).downto(0)
      if amounts_array[index].to_s == nil || amounts_array[index].to_s == "" || amounts_array[index].to_f < salary_average.to_f
        if index == 4
          amounts_array[4] = salary_average.to_s
          ids_array[4] = current_major_id.to_s
        else
          amounts_array[index], amounts_array[index+1] = swap_value(amounts_array[index], amounts_array[index+1])
          ids_array[index], ids_array[index+1] = swap_value(ids_array[index], ids_array[index+1])
        end
      end
    end
    top_major_ids = ids_array[0].to_s + "^" + ids_array[1].to_s + "^" + ids_array[2].to_s + "^" + ids_array[3].to_s + "^" + ids_array[4].to_s
    top_major_amounts = amounts_array[0].to_s + "^" + amounts_array[1].to_s + "^" + amounts_array[2].to_s + "^" + amounts_array[3].to_s + "^" + amounts_array[4].to_s
    return top_major_ids, top_major_amounts
  end

  def does_top_major_list_need_update(salary_average, top_major_amounts)
    amounts_array = top_major_amounts.split("^")
    if amounts_array[4].to_s == nil || amounts_array[4].to_s == "" || amounts_array[4].to_f < salary_average.to_f
      return true
    end
    return false
  end

  def get_lineage (full_string, index)
    str = full_string.split('_')[index]
    n1 = str[0].ord
    n2 = str[1].ord
    n3 = str[2].ord
    if n2 == 90 && n3 == 90
      str[0] = (str[0].ord + 1).chr
      str[1] = 65.chr
      str[2] = 65.chr
    elsif n3 == 90
      str[1] = (str[1].ord + 1).chr
      str[2] = 65.chr
    else
      str[2] = (str[2].ord + 1).chr
    end
    if index == 0
      return str + '_' + full_string.split('_')[1]
    else
      return full_string.split('_')[0] + '_' + str
    end
  end

  def remove_school_values (school_id)
    school = School.find(school_id)
    review = SchoolReview.find(params[:id])
    school.recommend_average = remove_bool_average(review.recommend_this_school, school.recommend_average, school.college_counter)
    school.party_average = remove_num_average(review.party_school, school.party_average, school.college_counter)
    school.worth_money_average = remove_bool_average(review.worth_money, school.worth_money_average, school.college_counter)
    school.rating_average = remove_num_average(review.rating, school.rating_average, school.college_counter)
    if (review.year_graduated >= (Date.today.year - 2))
      school.salary_average = remove_num_average(review.annual_salary, school.salary_average, school.two_year_college)
      school.debt_average = remove_num_average(review.debt, school.debt_average, school.two_year_college)
      school.two_year_college -= 1
    end
    school.college_counter -= 1
    school.save
  end
  def remove_bool_average (the_bool, the_average, the_counter)
    if the_counter == 1
      return 0
    end
    val = the_bool ? 1 : 0
    return ((the_average * the_counter) - val) / (the_counter - 1)
  end
  def remove_num_average (the_num, the_average, the_counter)
    if the_counter == 1
      return 0
    end
    return ((the_average * the_counter) - the_num) / (the_counter - 1)
  end
  def get_max_value (the_num)
    return the_num > 1000000 ? 1000001 : the_num
  end
  def update_num_average (the_num, the_average, the_counter)
    return ((the_average * the_counter) + the_num) / (the_counter + 1)
  end
  def update_bool_average (the_bool, the_average, the_counter)
    val = the_bool ? 1 : 0
    return ((the_average * the_counter) + val) / (the_counter + 1)
  end

  def validate_dollar_amount (amount)
    if amount == nil
      return nil
    end
    amount = amount.gsub("$","").gsub(",","")
    amount = amount.split(".")[0]
    if (amount =~ /\A[0-9]+\z/)
      return amount.to_f
    end
    return nil
  end

  def update_review_list_max(review_list, school_id, major_id)
    if (review_list == nil || review_list.to_s.length < 1)
      return school_id.to_s + "," + major_id.to_s + "^"
    end
    return review_list.concat(school_id.to_s + "," + major_id.to_s + "^")
  end

  def is_duplicate_review_max(review_list, school_id, major_id)
    if (review_list == nil || review_list.to_s.length < 1)
      return false
    end
    review_list_array = review_list.split("^")
    for review in review_list_array
      school_and_major_array = review.split(",")
      if school_and_major_array.length == 2
        if school_and_major_array[0].to_s == school_id.to_s && school_and_major_array[1].to_s == major_id.to_s
          return true
        end
      end
    end
    return false
  end

  def update_review_daily_count_max(review_daily_count)
    if (review_daily_count == nil || review_daily_count.to_s.length < 1)
      return Date.today.to_s + "^"
    end
    review_count_array = review_daily_count.split("^")
    if (review_count_array[0].to_s != Date.today.to_s)
      return Date.today.to_s + "^"
    end
    return review_daily_count.concat(Date.today.to_s + "^")
  end

  def did_user_hit_review_limit_max(review_daily_count)
    if (review_daily_count == nil || review_daily_count.to_s.length < 1)
      return false
    end
    review_count_array = review_daily_count.split("^")
    if (review_count_array[0].to_s == Date.today.to_s && review_count_array.length > 2)
      return true
    end
    return false
  end

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
