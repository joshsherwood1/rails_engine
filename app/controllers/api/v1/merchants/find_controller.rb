class Api::V1::Merchants::FindController < ApplicationController
  def show
    #binding.pry
    if params.keys.include?("name")
      name = params["name"]
      render json: MerchantSerializer.new(Merchant.find_by(name: name))
    elsif params.keys.include?("updated_at")
      updated_at = params["updated_at"]
      render json: MerchantSerializer.new(Merchant.find_by(updated_at: updated_at))
    else params.keys.include?("created_at")
      created_at = params["created_at"]
      render json: MerchantSerializer.new(Merchant.find_by(created_at: created_at))
    end
  end
end
