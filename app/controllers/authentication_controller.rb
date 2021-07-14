class AuthenticationController < ApplicationController
    def login
        user = User.find_by(username: params[:username])

        if !user
            render json: { "error": "Invalid username"}, status: :unauthorized
            puts "****************************************"
            p Rails.application.secrets.secret_key_base[0]
            puts "****************************************"
        elsif user.authenticate(params[:password])
            secret_key = Rails.application.secrets.secret_key_base[0]
            puts "****************************************"
            p secret_key
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
