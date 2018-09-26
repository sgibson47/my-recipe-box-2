module UsersHelper
  
  def five_most_recent_user_recipes
    @user.users_latest_recipes.five
  end

  def five_most_recent_user_makings
    @user.users_latest_makings.five
  end

end
