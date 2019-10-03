class Api::V1::Merchants::FindController < ApplicationController
  def show
    #binding.pry
    if params.keys.include?("name")
      render json: MerchantSerializer.new(Merchant.find_by(name: params["name"]))
    elsif params.keys.include?("updated_at")
      merchant = Merchant.find_by(updated_at: params["updated_at"])
      render json: MerchantSerializer.new(merchant)
    elsif params.keys.include?("id")
      render json: MerchantSerializer.new(Merchant.find(params["id"]))
    else params.keys.include?("created_at")
      merchant = Merchant.find_by(created_at: params["created_at"])
      render json: MerchantSerializer.new(merchant)
    end
  end

  def index
    if params.keys.include?("name")
      render json: MerchantSerializer.new(Merchant.find_by_name(params["name"]))
    else params.keys.include?("id")
      render json: MerchantSerializer.new(Merchant.find_by_id(params["id"]))
    end
  end
end
