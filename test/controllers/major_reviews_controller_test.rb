require 'test_helper'

class MajorReviewsControllerTest < ActionController::TestCase
  setup do
    @major_review = major_reviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:major_reviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create major_review" do
    assert_difference('MajorReview.count') do
      post :create, major_review: { annual_salary: @major_review.annual_salary, comment_count: @major_review.comment_count, debt: @major_review.debt, difficulty: @major_review.difficulty, position_title: @major_review.position_title, rating: @major_review.rating, recommend_this_major: @major_review.recommend_this_major, register_id: @major_review.register_id, review: @major_review.review, school_id: @major_review.school_id, title: @major_review.title, user_id: @major_review.user_id, vote_count: @major_review.vote_count, worth_money: @major_review.worth_money, year_graduated: @major_review.year_graduated }
    end

    assert_redirected_to major_review_path(assigns(:major_review))
  end

  test "should show major_review" do
    get :show, id: @major_review
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @major_review
    assert_response :success
  end

  test "should update major_review" do
    patch :update, id: @major_review, major_review: { annual_salary: @major_review.annual_salary, comment_count: @major_review.comment_count, debt: @major_review.debt, difficulty: @major_review.difficulty, position_title: @major_review.position_title, rating: @major_review.rating, recommend_this_major: @major_review.recommend_this_major, register_id: @major_review.register_id, review: @major_review.review, school_id: @major_review.school_id, title: @major_review.title, user_id: @major_review.user_id, vote_count: @major_review.vote_count, worth_money: @major_review.worth_money, year_graduated: @major_review.year_graduated }
    assert_redirected_to major_review_path(assigns(:major_review))
  end

  test "should destroy major_review" do
    assert_difference('MajorReview.count', -1) do
      delete :destroy, id: @major_review
    end

    assert_redirected_to major_reviews_path
  end
end
