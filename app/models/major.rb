class Major < ActiveRecord::Base
  def self.search(search)
    if search
      search = search.downcase
      tp = search.downcase
      if tp.length > 5
        if tp[(tp.length-2)..(tp.length-1)] == " a"
          tp[(tp.length-2)..(tp.length-1)] = " "
        elsif tp[(tp.length-2)..(tp.length-1)] == " o"
          tp[(tp.length-2)..(tp.length-1)] = " "
        elsif tp[(tp.length-2)..(tp.length-1)] == " t"
          tp[(tp.length-2)..(tp.length-1)] = " "
        elsif tp[(tp.length-3)..(tp.length-1)] == " at"
          tp[(tp.length-3)..(tp.length-1)] = " "
        elsif tp[(tp.length-3)..(tp.length-1)] == " an"
          tp[(tp.length-3)..(tp.length-1)] = " "
        elsif tp[(tp.length-3)..(tp.length-1)] == " of"
          tp[(tp.length-3)..(tp.length-1)] = " "
        elsif tp[(tp.length-3)..(tp.length-1)] == " th"
          tp[(tp.length-3)..(tp.length-1)] = " "
        elsif tp[(tp.length-4)..(tp.length-1)] == " and"
          tp[(tp.length-4)..(tp.length-1)] = " "
        elsif tp[(tp.length-4)..(tp.length-1)] == " the"
          tp[(tp.length-4)..(tp.length-1)] = " "
        end
      end
      tp = tp.gsub("@", " ").gsub(" at ", " ").gsub(".", " ").gsub(" of ", " ")
      tp = tp.gsub("&", " ").gsub(" and ", " ").gsub("-", " ").gsub(" the ", " ")
      tp = tp.gsub("(", " ").gsub(")", " ").gsub(",", " ").gsub("/", " ")
      tp = tp.gsub("?", "").gsub(" '", "").gsub("'", "").gsub(":", " ").gsub(" ", "")
      where("searchable like ?", "%#{tp}_%").limit(25)
      #where("searchable like ?", "%#{tp}_%").limit(10).pluck(:searchable_name)
    else
      Major.all
    end
  end
  
  def self.clickable_search(search)
    if search
      search = search.downcase
      tp = search.downcase
      if tp.length > 5
        if tp[(tp.length-2)..(tp.length-1)] == " a"
          tp[(tp.length-2)..(tp.length-1)] = " "
        elsif tp[(tp.length-2)..(tp.length-1)] == " o"
          tp[(tp.length-2)..(tp.length-1)] = " "
        elsif tp[(tp.length-2)..(tp.length-1)] == " t"
          tp[(tp.length-2)..(tp.length-1)] = " "
        elsif tp[(tp.length-3)..(tp.length-1)] == " at"
          tp[(tp.length-3)..(tp.length-1)] = " "
        elsif tp[(tp.length-3)..(tp.length-1)] == " an"
          tp[(tp.length-3)..(tp.length-1)] = " "
        elsif tp[(tp.length-3)..(tp.length-1)] == " of"
          tp[(tp.length-3)..(tp.length-1)] = " "
        elsif tp[(tp.length-3)..(tp.length-1)] == " th"
          tp[(tp.length-3)..(tp.length-1)] = " "
        elsif tp[(tp.length-4)..(tp.length-1)] == " and"
          tp[(tp.length-4)..(tp.length-1)] = " "
        elsif tp[(tp.length-4)..(tp.length-1)] == " the"
          tp[(tp.length-4)..(tp.length-1)] = " "
        end
      end
      tp = tp.gsub("@", " ").gsub(" at ", " ").gsub(".", " ").gsub(" of ", " ")
      tp = tp.gsub("&", " ").gsub(" and ", " ").gsub("-", " ").gsub(" the ", " ")
      tp = tp.gsub("(", " ").gsub(")", " ").gsub(",", " ").gsub("/", " ")
      tp = tp.gsub("?", "").gsub(" '", "").gsub("'", "").gsub(":", " ").gsub(" ", "")
      where("searchable like ?", "%#{tp}_%")
      #where("searchable like ?", "%#{tp}_%").limit(10).pluck(:searchable_name)
    else
      Major.all
    end
  end
end
