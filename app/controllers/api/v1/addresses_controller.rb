class Api::V1::AddressesController < ApplicationController
  include Pagination

  before_action :authenticate_with_token!
  respond_to :json

  def index
    addresses = Address.all.page(params[:page]).per(params[:per_page])

    options = {
      links: {
        first: api_v1_addresses_path(per_page: per_page),
        self: api_v1_addresses_path(page: current_page, per_page: per_page),
        last: api_v1_addresses_path(page: addresses.total_pages,per_page: per_page)
      },
      meta: pagination(addresses, per_page)
    }

    render json: AddressSerializer.new(addresses, options).serializable_hash
  end

  def show
    address = Address.find(params[:id])
    respond_with AddressSerializer.new(address).serializable_hash
  end

  def create
	  address = Address.new(address_params)

	  if address.save
	  	address.reload
	    render json: AddressSerializer.new(address).serializable_hash, status: :created, location: [:api, :v1, address]
	  else
	    render json: { errors: address.errors }, status: :unprocessable_entity
	  end
	end

  def update
    address = Address.find(params[:id])
    if address.update(address_params)
      render json: AddressSerializer.new(address).serializable_hash, status: :ok, location: [:api, :v1, address]
    else
      render json: { errors: address.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    head :no_content
  end

  private

    def address_params
      params.require(:data).require(:attributes).
        permit(:person_id, :address_type_id, :street, :zip, :city) ||
        ActionController::Parameters.new
    end
end
