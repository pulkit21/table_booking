class BookingController < ApplicationController

  before_action :set_booking, only: [:show, :update, :destroy]

  def create
    @booking = current_user.bookings.new(booking_params)
    if @booking.save
      render json: @booking, status: 201
    else
      render json: {errors: @booking.errors}, status: 422
    end
  end

  def index
    @bookings = current_user.bookings
    render json: @bookings, status: 200
  end

  def show
    render json: @booking, status: 200
  end

  def update
    if @booking.update(booking_params)
      render json: @booking, status: 200
    else
      render json: {errors: @booking.errors}, status: 422
    end
  end

  def destroy
    if @booking.present?
      @booking.destroy
      render json: @booking, status: 402
    end
  end


  #######
  private
  #######

    def set_booking
      @booking = current_user.bookings.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:booking_date,:number_of_seats, :booking_time, :restaurant_id, :user_id)
    end
end
