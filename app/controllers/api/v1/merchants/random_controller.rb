class Api::V1::Merchants::RandomController < ApplicationController

  def show
    merchant = Merchant.find(Merchant.get_random_id)
    render json: MerchantSerializer.new(merchant)
  end
end
