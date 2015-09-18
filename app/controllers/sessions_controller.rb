class SessionsController < Devise::SessionsController
  skip_before_filter :require_no_authentication, :only => [ :create]

  # POST /api/login
  def create
    if request.format == "text/html" || request.content_type == "text/html"
      super
    else
      resource = User.find_for_database_authentication(:email => params[:user][:email])
      return invalid_login_attempt unless resource
      if resource.valid_password?(params[:user][:password])
        sign_in(:user, resource)
        # TODO
        # resource.ensure_authentication_token
        if resource.present?
          render json: resource, status: 200
        end
        return
      end
      invalid_login_attempt
    end
  end

  # DELETE /api/logout
  def destroy
    if request.format == "text/html" || request.content_type == "text/html"
      super
    else
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      resource = User.find_for_database_authentication(:email => params[:email])
      # TODO
      # resource.authentication_token = nil
      resource.save
      render :json=> {:success=>true}
    end
  end

  #########
  protected
  #########

    def invalid_login_attempt
      render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
    end

end
