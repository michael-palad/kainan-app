class RestaurantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :verify_user, only: [:edit, :update, :destroy]
  before_action :find_params, only: [:show, :edit, :update, :destroy]
  
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
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant
    else
      render 'edit'  
    end
  end
  
  def destroy
    @restaurant.destroy
    redirect_to root_path
  end
  
  private
  
    def find_params
      @restaurant = Restaurant.find(params[:id])  
    end
  
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :telephone_number, :cuisine)  
    end
    
    def verify_user
      restaurant = Restaurant.find(params[:id])
      if current_user != restaurant.user
        redirect_to root_path  
      end
    end
end

