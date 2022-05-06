class UsersController < ApplicationController
  def create
    # create new User
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: {
               errors: user.errors.full_messages,
             },
             status: :unprocessable_entity
    end
    # save hashed password to db
    # save user's ID in the session hash
    # return user object json
  end

  def show
    # if User authenticated, return user obj
    current_user = User.find_by(id: session[:user_id])
    if current_user
      render json: current_user
    else
      render json: { error: 'Not authorized' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
