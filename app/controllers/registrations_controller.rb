class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, only: [ :create ]
  respond_to :json

  # POST /api/signup
  def create
    @user = build_resource(user_params)
    if resource.save
      render json: @user, status: 201
    else
      warden.custom_failure!
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  # PUT /api/profile
  def update
    resource_updated = resource.update(user_params)
    yield resource if block_given?
    if resource_updated
      render json: resource, status: 200
    else
      render json: { user: resource.errors } , status: :unprocessable_entity
    end
  end

  def destroy
    super
  end

  #######
  private
  #######

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
