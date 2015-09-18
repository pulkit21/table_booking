class PasswordsController < Devise::PasswordsController
  respond_to :json


  # POST /api/forgot_password
  def create
    @user = User.find_for_database_authentication(:email => params[:user][:email])
    if @user.confirmed?
      @user.generate_reset_password_code
      self.resource = resource_class.send_reset_password_instructions(params[:user])
      if resource.errors.empty?
        render json: resource, status: 201
      else
        render json: {user: {error: "Email not found please provide the valid email"} }, status: :unprocessable_entity
      end
    else
      render json: {user: {error: "Email is not confirmed! Please confirm your email"} }, status: :unprocessable_entity
    end
  end

  # PUT /api/reset_password?reset_password_token=1234
  def update
    if params[:user][:password].blank?
      render json: { user: {error: "Password cannot be blank"}}, status: 422
    else
      @user = User.find_for_database_authentication(:reset_password_token => params[:reset_password_token])
      if !@user.nil?
        resource = @user.set_new_password(params)
        if resource.errors.empty?
          resource.unlock_access! if unlockable?(resource)
          render json: resource, status: 201
        else
          render json: {error: resource.errors }, status: 422
        end
      else
        render json: {error: {user: "Invalide code"} }, status: 422
      end
    end
  end

end
