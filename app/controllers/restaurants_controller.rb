class RestaurantsController < ApplicationController

  before_action :set_restaurant, only: [:show, :update,:destroy]
  before_action :doorkeeper_authorize!
  respond_to    :json

  def index
    @restaurants  = current_user.restaurants
    render json: @restaurants, status: 200
  end

  def show
    render json: @restaurant, status: 200
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      render json: @restaurant, status: 201
    else
      render json: {errors: @restaurant.errors}, status: 422
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      render json: @restaurant, status: 200
    else
      render json: {errors: @restaurant.errors}, status: 422
    end
  end

  def destroy
    if @restaurant.present?
      @restaurant.destroy
      render json: {errors: @restaurant}, status: 204
    end
  end


  #######
  private
  #######

  def set_restaurant
    @restaurant = current_user.restaurants.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :contact_number, :cost_price)
  end


end
