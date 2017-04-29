module ApplicationHelper
  def user_submitted_restaurant?(restaurant)
    user_signed_in? && current_user == restaurant.user        
  end
end
