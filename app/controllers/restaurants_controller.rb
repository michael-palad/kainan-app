class RestaurantsController < ApplicationController
  before_action :find_params, only: [:show, :edit, :update]
  
  def index
    @restaurants = Restaurant.order(created_at: :desc)
  end
  
  def show
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
  
  def edit
  end
  
  def update
    
  end
  
  private
  
    def find_params
      @restaurant = Restaurant.find(params[:id])  
    end
  
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :telephone_number, :cuisine)  
    end
end

