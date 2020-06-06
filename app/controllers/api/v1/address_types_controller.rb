class Api::V1::AddressTypesController < ApplicationController
  include Pagination

  before_action :authenticate_with_token!
  respond_to :json

  def index
    address_types = AddressType.all.page(params[:page]).per(params[:per_page])

    options = {
      links: {
        first: api_v1_address_types_path(per_page: per_page),
        self: api_v1_address_types_path(page: current_page, per_page: per_page),
        last: api_v1_address_types_path(page: address_types.total_pages,per_page: per_page)
      },
      meta: pagination(address_types, per_page)
    }
 
    render json: AddressTypeSerializer.new(address_types, options).serializable_hash
  end

  def show
    addres_type = AddressType.find(params[:id])
    respond_with AddressTypeSerializer.new(addres_type).serializable_hash
  end
end
