class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :update, :destroy]

  def index
    @applications = Doorkeeper::Application.where("owner_id IS NULL")
    render json: @applications, status: 200
  end

  def show
    render json: @application, status: 200
  end

  def create
    @application = Doorkeeper::Application.new(application_params)

    if @application.save
      render json: @application, status: 201
    else
      render json: @application.errors, status: 422
    end
  end

  def update
    if @application.update(application_params)
      render json: @application, status: 200
    else
      render json: @application.errors, status: 422
    end
  end

  def destroy
    @application.destroy
    render json: @application, status: 204
  end

  private

  def set_application
    @application = Doorkeeper::Application.where("owner_id IS NULL").find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def application_params
    params[:doorkeeper_application].permit(:name, :redirect_uri)
  end
end
