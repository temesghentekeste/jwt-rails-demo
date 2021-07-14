class AuthenticationController < ApplicationController
    def login
        user = User.find_by(username: params[:username])
        puts "****************************************"
        p Rails.application.secrets.secret_key_base[0]
        puts "****************************************"

        if !user
            render json: { "error": "Invalid username"}, status: :unauthorized
        elsif user.authenticate(params[:password])
            secret_key = Rails.application.secrets.secret_key_base[0]
            puts "****************************************"
            p secret_key
            puts "****************************************"
            p ENV["SECRET_KEY_BASE"]
            puts "****************************************"
            p secret_key_base
            puts "****************************************"
            token = JWT.encode(
                {
                    id: user.id,
                    username: user.username,
                }, secret_key)
            render json: { token: token }
        else
            render status: :unauthorized
        end
    end
end
