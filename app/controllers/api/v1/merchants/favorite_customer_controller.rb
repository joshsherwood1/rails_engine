class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    #favorite_customer = merchant.find_favorite_customer
    render json: MerchantSerializer.new(merchant)
  end
end
