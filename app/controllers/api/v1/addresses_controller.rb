class Api::V1::AddressesController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
    addresses = Address.all.page(params[:page]).per(params[:per_page])
    render json: addresses, meta: pagination(addresses, params[:per_page])
  end

  def show
    respond_with Address.find(params[:id])
  end

  def create
	  address = Address.new(address_params)

	  if address.save
	  	address.reload
	    render json: address, status: 201, location: [:api, :v1, address]
	  else
	    render json: { errors: address.errors }, status: 422
	  end
	end

  def update
    address = Address.find(params[:id])
    if address.update(address_params)
      render json: address, status: 200, location: [:api, :v1, address]
    else
      render json: { errors: address.errors }, status: 422
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    head 204
  end

  private

    def address_params
      params.require(:address).permit(:person_id, :address_type_id, :street, :zip, :city)
    end
end
