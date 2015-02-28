json.array!(@major_reviews) do |major_review|
  json.extract! major_review, :id, :school_id, :year_graduated, :recommend_this_major, :difficulty, :rating, :annual_salary, :user_id, :worth_money, :debt, :review, :title, :position_title, :register_id, :vote_count, :comment_count
  json.url major_review_url(major_review, format: :json)
end
