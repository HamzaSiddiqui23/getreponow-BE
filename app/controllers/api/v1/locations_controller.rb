module Api
  module V1
    class LocationsController < BaseController
      protect_from_forgery with: :null_session

      def index
        locations = current_company.locations.includes(:address).all
        render json: locations, include: :address
      end
    
      def show
        location = current_company.locations.find(params[:id])
        render json: location, include: :address
      end
    
      def create
        location = current_company.locations.new(location_params)
        if location.save
          render json: location, include: :address, status: :created
        else
          render json: { errors: location.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        location = current_company.locations.find(params[:id])
        if location.update(location_params.except(:address_attributes))
          render json: location
        else
          render json: { error: location.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Location not found' }, status: :not_found
      end
    
      private
    
      def location_params
        params.require(:location).permit(:name, :active, :location_email, :google_review_url, address_attributes: [:street, :city, :state, :zip, :country, :suite])
      end
    end
  end
end