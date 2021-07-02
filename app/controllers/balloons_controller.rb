class BalloonsController < ApplicationController
    def index
        balloons = Balloon.all

        render json: {balloons: balloons}
    end

    def create 
        balloon = Balloon.new(name: params[:name])

        authorized_headers = request.headers[:authorization]

        if(authorized_headers)
            token = authorized_headers.split(" "[1])
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
