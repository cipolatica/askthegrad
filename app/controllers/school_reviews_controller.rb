class SchoolReviewsController < ApplicationController
  helper_method :is_signed_in
  def index
    @school = params[:the_school]
    @school_id = @school["school_id"]
    if params[:sort] != nil
      if params[:sort] == "most_recent"
        @reviews = SchoolReview.where(school_id:@school_id).order(created_at: :desc)
      elsif params[:sort] == "graduation_year"
        @reviews = SchoolReview.where(school_id:@school_id).order(year_graduated: :desc)
      elsif params[:sort] == "highest_paying"
        @reviews = SchoolReview.where(school_id:@school_id).order(annual_salary: :desc)
      elsif params[:sort] == "major_name_alphabetical"
        @reviews = SchoolReview.where(school_id:@school_id).order(:major_name)
      else
        @reviews = SchoolReview.where(school_id:@school_id, major_id:params[:sort].to_i).order(created_at: :desc)
      end
    else
      @reviews = SchoolReview.where(school_id:@school_id).order(created_at: :desc)
    end
    
    @school = School.find(@school_id)
    @title = @school.name
    @small_text = @school.city
    @state = State.find(@school.state_id)
  end

  def show
    @title = "School Review"
    @school_review = SchoolReview.find(params[:id])
    @school_id = @school_review.school_id
    @comments = Comment.where(college_review_id:@school_review.id).order(lineage: :asc)
    @comment = Comment.new
  end
  
  def new
    @school = params[:the_school]
    @school_id = @school["school_id"]
    @school_name = School.find(@school_id).name
    # @school_review = SchoolReview.new

    if session[:school_id_for_major] != nil
      @school_id = session[:school_id_for_major]
    end
    @major_id = params[:major_id]
    @major = Major.find(@major_id)
    @review = SchoolReview.new
  end
  
  def edit
    @school_review = SchoolReview.find(params[:id])
    @school_id = @school_review.school_id
  end
  
  def update
    @school_review = SchoolReview.find(params[:id])
    if user_signed_in? && @school_review.user_id == current_user.id
      @school_id = @school_review.school_id
      review = SchoolReview.new(review_params)
      if review.valid?
        remove_school_values(@school_id)
      end
      if @school_review.update(review_params)
        @school_review.update(annual_salary:get_max_value(review.annual_salary), debt:get_max_value(review.debt))
        school = School.find(@school_review.school_id)
        if school.college_counter == nil
          school.college_counter = 0
        end
        if school.two_year_college == nil
          school.two_year_college = 0
        end
        school.recommend_average = update_bool_average(@school_review.recommend_this_school, school.recommend_average, school.college_counter)
        school.party_average = update_num_average(@school_review.party_school, school.party_average, school.college_counter)
        school.worth_money_average = update_bool_average(@school_review.worth_money, school.worth_money_average, school.college_counter)
        school.rating_average = update_num_average(@school_review.rating, school.rating_average, school.college_counter)
        if (@school_review.year_graduated >= (Date.today.year - 2))
          school.salary_average = update_num_average(@school_review.annual_salary, school.salary_average, school.two_year_college)
          school.debt_average = update_num_average(@school_review.debt, school.debt_average, school.two_year_college)
          school.two_year_college += 1
        end
        school.college_counter += 1
        school.save
        
        redirect_to @school_review
      else
        render "edit"
      end
    else
      render "edit"
    end
  end
  
  def create
    #render plain: params[:school_review].inspect
    @review = SchoolReview.new(review_params)
    @school_id = @review.school_id
    if @review.valid?
      @review.annual_salary = get_max_value(@review.annual_salary)
      @review.debt = get_max_value(@review.debt)
      @review.major_name = Major.find(@review.major_id).name
      @review.user_id = user_signed_in? ? current_user.id : nil;
      @review.user_name = user_signed_in? ? current_user.username : nil;
    end
    if @review.save
      if user_signed_in?
        school = School.find(@review.school_id)
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
        school.recommend_average = update_bool_average(@review.recommend_this_school, school.recommend_average, school.college_counter)
        school.party_average = update_num_average(@review.party_school, school.party_average, school.college_counter)
        school.worth_money_average = update_bool_average(@review.worth_money, school.worth_money_average, school.college_counter)
        school.rating_average = update_num_average(@review.rating, school.rating_average, school.college_counter)
        if (@review.year_graduated >= (Date.today.year - 2))
          school.salary_average = update_num_average(@review.annual_salary, school.salary_average, school.two_year_college)
          school.debt_average = update_num_average(@review.debt, school.debt_average, school.two_year_college)
          school.two_year_college += 1
          # Find top 5 highest paying colleges
          review_list = SchoolReview.where(school_id:@school_id, year_graduated:(Date.today.year - 2)..Date.today.year).order(:major_id)
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
        school.college_counter += 1
        school.save
        
        redirect_to @review
      else
        reg = Registration.new(school_review_id:@review.id, school_id:@review.school_id)
        reg.save
        @review.update(register_id: reg.id, school_id:nil)
        session[:reg_id] = reg.id
        redirect_to authentication_required_index_path
      end
    else
      @major_id = @review.major_id
      render "major_reviews/new"
    end
  end
  
  def destroy
  end

  def comment
    @comment = Comment.new
    @school_review = SchoolReview.find(params[:id])
    @comments = Comment.where(college_review_id:@school_review.id).order(lineage: :asc)
    @value = '#comm_' + params[:comm_id]
    @comment_id = params[:comm_id]
    respond_to do |format|
      format.html { redirect_to :back, notice: "you can't comment" }
      format.js
    end
  end
  
  def post_comments
    #render plain: params[:comment].inspect
    @school_review = SchoolReview.find(params[:id])
    @school_id = @school_review.school_id
    @comment = Comment.new
    if user_signed_in?
      is_parent = params[:comment][:comm_id] && params[:comment][:comm_id].length > 0 ? false : true
      lineage_index = is_parent ? 0 : 1
      comment = Comment.new(comment_params)
      comment.lineage = get_lineage(params[:comment][:lineage], lineage_index)
      comment.username = current_user.username
      comment.user_id = current_user.id
      comment.college_review_id = params[:id]
      comment.is_parent = is_parent
      if comment.save
        if @school_review.comment_count == nil
          @school_review.update(comment_count:1)
        else
          @school_review.update(comment_count: @school_review.comment_count + 1)
        end
        @comments = Comment.where(college_review_id:@school_review.id).order(lineage: :asc)
        email_hash = {}
        review_user = User.find(@school_review.user_id)
        if comment.is_parent && current_user.id != review_user.id
          CommentsMailer.parent_comment(review_user, comment).deliver
        elsif comment.is_parent == false
          if current_user.id != review_user.id
            CommentsMailer.child_comment(review_user, comment.content, comment.username).deliver
          end
          @comments.each do |c|
            if c.lineage.split('_')[0] == comment.lineage.split('_')[0] && c.user_id != review_user.id
              email_hash[c.username] = c.user_id
            end
          end
          email_hash.each do |key, value|
            thread_user = User.find(value)
            CommentsMailer.child_comment(thread_user, comment.content, comment.username).deliver
          end
        end
        respond_to do |format|
          format.html { redirect_to :back, notice: "Thanks for voting" }
          format.js
        end
      end
      
    else
      respond_to do |format|
        format.html { redirect_to :back, notice: "You must be signed in to vote" }
        format.js { render :js => "alert('You must be signed in to vote');" }
      end
    end
  end

  def vote
    if user_signed_in?
      value = params[:type] == "up" ? 1 : -1
      @school_review = SchoolReview.find(params[:id])
      if !@school_review.has_evaluation?(:votes, current_user)
        @school_review.vote_count = @school_review.vote_count == nil ? 1 : @school_review.vote_count + 1
        @school_review.save
      end
      @school_review.add_or_update_evaluation(:votes, value, current_user)
      if @school_review.vote_count
        @likes = ((@school_review.reputation_for(:votes) + @school_review.vote_count)/(@school_review.vote_count * 2)) * @school_review.vote_count
        @dislikes = @school_review.vote_count - @likes
      elsif
        @likes = 0
        @dislikes = 0
      end
      respond_to do |format|
        format.html { redirect_to :back, notice: "Thanks for voting" }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, notice: "You must be signed in to vote" }
        format.js { render :js => "alert('You must be signed in to vote');" }
      end
    end
  end
  
  def is_signed_in
    if user_signed_in?
      flash.now[:alert] = 'user signed in'
    else
      flash.now[:alert] = 'not signed in'
    end
  end
  
  private
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
  
  def comment_params
    params.require(:comment).permit(:content, :lineage, :comm_id)
  end
  
  def review_params
    params.require(:school_review).permit(:school_id, :year_graduated, :recommend_this_school, :recommend_this_major, :party_school, :difficulty, :rating, :annual_salary, :user_id, :worth_money, :debt, :review, :title, :position_title, :register_id, :vote_count, :comment_count, :major_id)
  end
end







