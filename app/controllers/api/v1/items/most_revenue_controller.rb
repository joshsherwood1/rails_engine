class Api::V1::Items::MostRevenueController < ApplicationController
  def index
    @quantity = params["quantity"].to_i
    set_of_items = Item.items_with_most_revenue(@quantity)
    render json: ItemSerializer.new(set_of_items)
  end
end
