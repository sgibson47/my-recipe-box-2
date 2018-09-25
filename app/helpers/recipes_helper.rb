module RecipesHelper
  def new_link
    link_to "Newest to Oldest", recipes_path(:sort => "new")
  end

  def old_link
    link_to "Oldest to Newest", recipes_path(:sort => "old")
  end

  def most_link
    link_to "Most to Least", recipes_path(:sort => "most")
  end

  def least_link
    link_to "Least to Most", recipes_path(:sort => "least")
  end
      

  def best_link
    link_to "Best to Worst", recipes_path(:sort => "best")
  end

  def worst_link
    link_to "Worst to Best", recipes_path(:sort => "worst")
  end

end
