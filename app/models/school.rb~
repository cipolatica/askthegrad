class School < ActiveRecord::Base
  belongs_to :states
  has_many :majors
  has_many :school_reviews
  
  def self.search(search)
    if search
      search = search.downcase
      tp = search.downcase
      tp = tp.gsub("@", " ").gsub(" at ", " ").gsub(".", " ").gsub(" of ", " ")
      tp = tp.gsub("&", " ").gsub(" and ", " ").gsub("-", " ").gsub(" the ", " ")
      tp = tp.gsub("(", " ").gsub(")", " ").gsub(",", " ").gsub("/", " ")
      tp = tp.gsub("?", "").gsub(" '", "").gsub("'", "").gsub(":", " ").gsub(" ", "")
      where("searchable like ?", "%#{tp}_%").limit(25)
      #where("searchable like ?", "%#{tp}_%").limit(10).pluck(:searchable_name)
    else
      School.all
    end
  end
  def self.clickable_search(search)
    if search
      search = search.downcase
      tp = search.downcase
      tp = tp.gsub("@", " ").gsub(" at ", " ").gsub(".", " ").gsub(" of ", " ")
      tp = tp.gsub("&", " ").gsub(" and ", " ").gsub("-", " ").gsub(" the ", " ")
      tp = tp.gsub("(", " ").gsub(")", " ").gsub(",", " ").gsub("/", " ")
      tp = tp.gsub("?", "").gsub(" '", "").gsub("'", "").gsub(":", " ").gsub(" ", "")
      where("searchable like ?", "%#{tp}_%")
      #where("searchable like ?", "%#{tp}_%").limit(10).pluck(:searchable_name)
    else
      School.all
    end
  end
end
