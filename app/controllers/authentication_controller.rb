class AuthenticationController < ApplicationController
    def login
        user = User.find_by(username: params[:username])

        if !user
            render json: { "error": "Invalid username"}, status: :unauthorized
        elsif user.authenticate(params[:password])
            render json: { "message": "Correct password"}
        else
            render json: { "message": "Wrong passord"}, status: :unauthorized
        end
    end
end
