module ApplicationHelper
  def user_submitted_restaurant?(restaurant)
    user_signed_in? && current_user == restaurant.user        
  end
  
  def get_page_title
    if controller_name == 'restaurants'
      if action_name == 'random'
        return 'Random'
      elsif action_name == 'cuisine_filter'
        cuisine_name = params[:name] || ''
        return cuisine_name.capitalize + ' Cuisines'
      elsif action_name == 'most_popular'
        return 'Most Popular'
      elsif action_name == 'starred_filter'
        return 'My Starred Restaurants'
      else
        return "let's eat"
      end
    end
  end
  
  def get_active_if_current(path)
    current_page?(path) ? 'active' : ''
  end
  
  def get_active_for_cuisine
    controller_name == 'restaurants' && action_name == 'cuisine_filter' ?
      'active' : ''
  end
  
  def pagination_shown?
    action_name != 'random'
  end
end
