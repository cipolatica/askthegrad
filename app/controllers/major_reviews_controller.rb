class MajorReviewsController < ApplicationController
  before_action :set_major_review, only: [:show, :edit, :update, :destroy]

  # GET /major_reviews
  # GET /major_reviews.json
  def index
    @major_id = params[:major_id]
    @major_reviews = MajorReview.where(school_id:@major_id)
    
    @major = Major.find(@major_id)
    @title = @major.name

  end

  # GET /major_reviews/1
  # GET /major_reviews/1.json
  def show
  end

  # GET /major_reviews/new
  def new
    @major_review = MajorReview.new
  end

  # GET /major_reviews/1/edit
  def edit
  end

  # POST /major_reviews
  # POST /major_reviews.json
  def create
    @major_review = MajorReview.new(major_review_params)

    respond_to do |format|
      if @major_review.save
        format.html { redirect_to @major_review, notice: 'Major review was successfully created.' }
        format.json { render :show, status: :created, location: @major_review }
      else
        format.html { render :new }
        format.json { render json: @major_review.errors, status: :unprocessable_entity }
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
      params.require(:major_review).permit(:school_id, :year_graduated, :recommend_this_major, :difficulty, :rating, :annual_salary, :user_id, :worth_money, :debt, :review, :title, :position_title, :register_id, :vote_count, :comment_count)
    end
end
