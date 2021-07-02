class BalloonsController < ApplicationController
    def index
        balloons = Balloon.all

        render json: {balloons: balloons}
    end

    def create 
        
        authorized_headers = request.headers[:authorization]
        
        if(authorized_headers)
            token = authorized_headers.split(" ")[1]
            secret_key = Rails.application.secrets.secret_key_base[0]
            decoded_token = JWT.decode(token, secret_key)
            
            user = User.find(decoded_token[0]["id"])
            balloon = Balloon.new(name: params[:name], user_id: user.id)
            if balloon.save 
                render json: {balloon: balloon}, status: :created
            else
                reder json: { error: "Something went wrong"}, status: :unprocessable_entity
            end
        else
            render status: :unauthorized
        end

      
    end
end
