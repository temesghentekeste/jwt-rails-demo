class BalloonsController < ApplicationController
    before_action :authenticate, only: [:create]
    def index
        balloons = Balloon.all

        render json: {balloons: balloons}
    end

    def create 
        balloon = Balloon.new(name: params[:name], user_id: @user.id)

        if balloon.save 
            render json: {balloon: balloon}, status: :created
        else
            reder json: { error: "Something went wrong"}, status: :unprocessable_entity
        end
    end
end
