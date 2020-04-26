class SightingsController < ApplicationController

    def index
        sightings = Sighting.all
        render json: sightings, only: [:id, :bird_id, :location_id]
    end

    # def show
    #     sighting = Sighting.find_by(id: params[:id])
    #     render json: {id: sighting.id, bird: sighting.bird, location: sighting.location}
    # end

    # def show
    #     sighting = Sighting.find_by(id: params[:id])
    #     if sighting
    #       render json: sighting, include: [:bird, :location]
    #     else
    #       render json: { message: 'No sighting found with that id' }
    #     end
    # end

    def show
        sighting = Sighting.find_by(id: params[:id])
        if sighting
            render json: sighting.to_json(:include => {
            :bird => {:only => [:name, :species]},
            :location => {:only => [:latitude, :longitude]}
            }, :except => [:updated_at])
        else
            render json: {message: "No sighting found with that id"}
        end
      end

end
