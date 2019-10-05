class Api::V1::Merchants::RandomController < ApplicationController

  def show
    merchant = Merchant.find(Merchant.pluck(:id).sample)
    render json: MerchantSerializer.new(merchant)
  end
end
