class BalloonsController < ApplicationController
    def index
        balloons = Balloon.all

        render json: balloons
    end

    def create 
        balloon = Balloon.new(name: params[:name])

        if balloon.save 
            render json: balloon, status: :created
        else
            reder json: { error: "Something went wrong"}, status: :unprocessable_entity
        end
    end
end
