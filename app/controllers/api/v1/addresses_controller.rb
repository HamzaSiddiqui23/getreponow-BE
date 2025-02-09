module Api
  module V1
    class AddressesController < BaseController
      protect_from_forgery with: :null_session

      def show
        address = Address.find(params[:id])
        render json: address
      end

      def update
        address = Address.find(params[:id])
        if address.update(address_params)
          render json: address
        else
          render json: { error: address.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Address not found' }, status: :not_found
      end
    
      private
    
      def address_params
        params.require(:address).permit(:street, :city, :state, :zip, :country, :suite)
      end
    end
  end
end