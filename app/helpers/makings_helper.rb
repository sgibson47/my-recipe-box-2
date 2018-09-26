module MakingsHelper
  
  def five_most_recent_recipes
    Making.latest.five
  end


end