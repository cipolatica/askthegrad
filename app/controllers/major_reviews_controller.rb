class MajorReviewsController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :set_major_review, only: [:show, :edit, :update, :destroy]

  # GET /major_reviews
  # GET /major_reviews.json
  def index
    if session[:school_id_for_major] != nil
      redirect_to new_major_review_path(:major_id => params[:major_id]) and return
    end
    #@major_reviews = MajorReview.where(major_id:@major_id)
    @has_modal_displayed = true
    if params[:the_major] != nil
      @the_major = params[:the_major]
      @major_id = @the_major["major_id"]
    else
      @major_id = params[:major_id]
    end
    if not is_integer_sql_safe(@major_id)
      logger.debug "major_reviews.controller: index not sql safe"
      return
    end
    @major = Major.find(@major_id)
    @title = @major.name
    @selected_sort_order = "most_recent"
    if params[:sort] != nil
      if params[:sort] == "most_recent"
        @reviews = SchoolReview.where(major_id:@major_id).order(created_at: :desc)
      elsif params[:sort] == "graduation_year"
        @selected_sort_order = "graduation_year"
        @reviews = SchoolReview.where(major_id:@major_id).order(year_graduated: :desc)
      elsif params[:sort] == "highest_paying"
        @selected_sort_order = "highest_paying"
        @reviews = SchoolReview.where(major_id:@major_id).order(annual_salary: :desc)
      elsif params[:sort] == "college_name_alphabetical"
        @selected_sort_order = "college_name_alphabetical"
        @reviews = SchoolReview.where(major_id:@major_id).order(:school_name)
      else
        @reviews = SchoolReview.where(major_id:@major_id, school_id:params[:sort].to_i).order(created_at: :desc)
      end
    else
      if session[:modal_for_major_reviews_index] == nil
        @has_modal_displayed = false
        session[:modal_for_major_reviews_index] = true
      end
      @reviews = SchoolReview.where(major_id:@major_id).order(created_at: :desc)
    end

  end

  # GET /major_reviews/1
  # GET /major_reviews/1.json
  def show
  end

  # GET /major_reviews/new
  # def new
  #   @school = params[:the_school]
  #   @school_id = @school["school_id"]
  #   @school_name = School.find(@school_id).name
  #   # @school_review = SchoolReview.new
  #
  #   if session[:school_id_for_major] != nil
  #     @school_id = session[:school_id_for_major]
  #   end
  #   @major_id = params[:major_id]
  #   @major = Major.find(@major_id)
  #   @review = SchoolReview.new
  # end
  def new
    @school_id = nil
    if session[:school_id_for_major] != nil
      @school_id = session[:school_id_for_major]
      if not is_integer_sql_safe(@school_id)
        logger.debug "major_reviews.controller: new: not sql safe"
        return
      end
      @small_text = School.find(@school_id).name
      @major_id = params[:major_id]
      if not is_integer_sql_safe(@major_id)
        logger.debug "major_reviews.controller: new: not sql safe"
        return
      end
      @major = Major.find(@major_id)
      @review = SchoolReview.new # Returning a School Review here because we are just using one review object and this has more functionality
    elsif session[:major_id_for_school] != nil
      @major_id = session[:major_id_for_school]
      if not is_integer_sql_safe(@major_id)
        logger.debug "major_reviews.controller: new: not sql safe"
        return
      end
      @school_id = params[:school_id]
      if not is_integer_sql_safe(@school_id)
        logger.debug "major_reviews.controller: new: not sql safe"
        return
      end
      @small_text = School.find(@school_id).name
      @major = Major.find(@major_id)
      @review = SchoolReview.new # Returning a School Review here because we are just using one review object and this has more functionality
    end
  end

  # GET /major_reviews/1/edit
  def edit
  end

  # POST /major_reviews
  # POST /major_reviews.json
  def create
    # render plain: params[:school_review].inspect

    # @review = SchoolReview.new(major_review_params)
    # respond_to do |format|
    #   if @review.save
    #     format.html { redirect_to @review, notice: 'Major review was successfully created.' }
    #     format.json { render :show, status: :created, location: @review }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @review.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /major_reviews/1
  # PATCH/PUT /major_reviews/1.json
  def update
    #respond_to do |format|
    #  if @major_review.update(major_review_params)
    #    format.html { redirect_to @major_review, notice: 'Major review was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @major_review }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @major_review.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /major_reviews/1
  # DELETE /major_reviews/1.json
  def destroy
    #@major_review.destroy
    #respond_to do |format|
    #  format.html { redirect_to major_reviews_url, notice: 'Major review was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_major_review
      if not is_integer_sql_safe(params[:id])
        logger.debug "major_reviews.controller: set_major_review: not sql safe"
        return
      end
      @major_review = MajorReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def major_review_params
      params.require(:school_review).permit(:school_id, :year_graduated, :recommend_this_school, :recommend_this_major, :party_school, :difficulty, :rating, :annual_salary, :user_id, :worth_money, :debt, :review, :title, :position_title, :register_id, :vote_count, :comment_count, :major_id, :school_name)
    end
end
