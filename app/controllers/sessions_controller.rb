class SessionsController < ApplicationController
  # skip_before_action :authorized, only: :create

  def create
    # responds to POST login request

    user = User.find_by(username: params[:username])

    # checks if user exists AND is authenticated:
    if user&.authenticate(params[:password])
      # creates a new session, saving user id as session id
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: {
               error: {
                 login: 'Invalid username or password',
               },
             },
             status: :unauthorized
    end
  end

  def destroy
    # responds to DELETE logout request
    session.delete :user_id
    head :no_content
  end
end
