class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    @date = params["date"]
    total_revenue = Merchant.total_revenue_for_specified_day(@date)
    render json: RevenueSerializer.new(total_revenue.values.pop).json
  end
end
