class RestaurantsController < ApplicationController
  before_action :find_restaurant ,only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :owner, only: [:edit, :update, :destroy]

  def index
    p "-----------------------------------------"
    @restaurants = Restaurant.all
  end

  def show
    @current_user = current_user
    @owner = find_restaurant.user
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    
    if @restaurant.save
      redirect_to @restaurant
    else
      render :new
    end
  end

  def edit
    if current_user != Restaurant.find(params[:id]).user
      redirect_to Restaurant.find(params[:id])
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy

    redirect_to restaurants_path
  end

  private

  def owner
    @owner = find_restaurant.user
    if current_user == nil
      redirect_to root
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :location, :cuisine, :description, :image)
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
