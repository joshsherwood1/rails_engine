class Api::V1::Merchants::FindController < ApplicationController
  def show
    #binding.pry
    if params.keys.include?("name")
      name = params["name"]
      render json: MerchantSerializer.new(Merchant.find_by(name: name))
    else params.keys.include?("id")
    end
  end
end
