class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.order(created_at: :desc)
  end
  
  def new
    @restaurant = Restaurant.new
  end
  
  def create
    @restaurant = current_user.restaurants.build(restaurant_params)
    if @restaurant.save
      redirect_to root_path  
    else
      render 'new'
    end
  end
  
  private
  
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :telephone_number, :cuisine)  
    end
end

