class Api::V1::AddressTypesController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
    address_types = AddressType.all.page(params[:page]).per(params[:per_page])
    render json: address_types, meta: pagination(address_types, params[:per_page])
  end

  def show
    respond_with AddressType.find(params[:id])
  end
end
