class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    @quantity = params["quantity"].to_i
    set_of_merchants = Merchant.merchants_with_most_revenue(@quantity)
    render json: MerchantSerializer.new(set_of_merchants)
  end
end
