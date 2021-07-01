class UsersController < ApplicationController
  def create
    user = User.new(
        name: params[:name], 
        username: params[:username], 
        password: params[:password], 
        email: params[:email]
      )

    if user.save
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private 
  
 
end
