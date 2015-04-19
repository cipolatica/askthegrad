class MajorReviewsController < ApplicationController
  before_action :set_major_review, only: [:show, :edit, :update, :destroy]

  # GET /major_reviews
  # GET /major_reviews.json
  def index
    if session[:school_id_for_major] != nil
      redirect_to new_major_review_path(:major_id => params[:major_id]) and return
    end
    @major_id = params[:major_id]
    @major_reviews = MajorReview.where(major_id:@major_id)
    
    @major = Major.find(@major_id)
    @title = @major.name

  end

  # GET /major_reviews/1
  # GET /major_reviews/1.json
  def show
  end

  # GET /major_reviews/new
  def new
    @school_id = nil
    if session[:school_id_for_major] != nil
      @school_id = session[:school_id_for_major]
    end
    @major_id = params[:major_id]
    @major = Major.find(@major_id)
    @review = SchoolReview.new # Returning a School Review here because we are just using one and this has more functionality
  end

  # GET /major_reviews/1/edit
  def edit
  end

  # POST /major_reviews
  # POST /major_reviews.json
  def create
    @review = SchoolReview.new(major_review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Major review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /major_reviews/1
  # PATCH/PUT /major_reviews/1.json
  def update
    respond_to do |format|
      if @major_review.update(major_review_params)
        format.html { redirect_to @major_review, notice: 'Major review was successfully updated.' }
        format.json { render :show, status: :ok, location: @major_review }
      else
        format.html { render :edit }
        format.json { render json: @major_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /major_reviews/1
  # DELETE /major_reviews/1.json
  def destroy
    @major_review.destroy
    respond_to do |format|
      format.html { redirect_to major_reviews_url, notice: 'Major review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_major_review
      @major_review = MajorReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def major_review_params
      params.require(:school_review).permit(:school_id, :year_graduated, :recommend_this_school, :recommend_this_major, :party_school, :difficulty, :rating, :annual_salary, :user_id, :worth_money, :debt, :review, :title, :position_title, :register_id, :vote_count, :comment_count, :major_id)
    end
end
