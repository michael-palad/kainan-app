class RestaurantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show,
                  :give_me_3, :cuisine_filter, :most_popular]
  before_action :verify_user, only: [:edit, :update, :destroy]
  before_action :find_params, only: [:show, :edit, :update, :destroy,
                              :give_star, :remove_star]
  
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
  
  def give_star
    @restaurant.starring_users << current_user
    redirect_to @restaurant
  end
  
  def remove_star
    @restaurant.starring_users.delete(current_user)
    redirect_to @restaurant
  end
  
  def give_me_3
    if Restaurant.count > 3
      ids = Restaurant.pluck(:id)
      @restaurants = Restaurant.find(ids.sample(3))
    else
      @restaurants = Restaurant.all  
    end
    render 'index'
  end
  
  def cuisine_filter
    @restaurants = Restaurant.where('cuisine = ?', params[:name].capitalize)  
    render 'index'
  end  
  
  def most_popular
    @restaurants = Restaurant.order(stars_count: :desc)
    render 'index'
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

