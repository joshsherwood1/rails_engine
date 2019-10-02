class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def most_revenue_for_merchants
    @quantity = params["quantity"].to_i
    set_of_merchants = Merchant.merchants_with_most_revenue(@quantity)
    render json: MerchantSerializer.new(set_of_merchants)
  end
end
