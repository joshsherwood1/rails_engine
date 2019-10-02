class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def most_revenue_for_merchants
    render json: MerchantSerializer.new(Merchant.all)
  end
end
