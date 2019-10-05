class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    @items_for_merchant = Merchant.find(params[:id]).items
    render json: ItemSerializer.new(@items_for_merchant)
  end
end
