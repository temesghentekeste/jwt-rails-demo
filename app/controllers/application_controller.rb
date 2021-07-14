class ApplicationController < ActionController::API
    def authenticate
        authorized_headers = request.headers[:authorization]
        secret_key_base = Rails.application.secrets.secret_key_base ? Rails.application.secrets.secret_key_base : ENV["SECRET_KEY_BASE"]
        if(authorized_headers)
            token = authorized_headers.split(" ")[1]
            secret_key = secret_key_base[0]
            decoded_token = JWT.decode(token, secret_key)
            
            @user = User.find(decoded_token[0]["id"])
        else
            render status: :unauthorized
        end 
    end
end
