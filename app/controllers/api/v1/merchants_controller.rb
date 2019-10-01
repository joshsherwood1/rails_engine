class Api::V1::ItemsController < ApplicationController
  def index
    render json: Merchant.all
  end
end
