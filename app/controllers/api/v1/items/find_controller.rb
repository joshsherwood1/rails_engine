class Api::V1::Items::FindController < ApplicationController
  def show
    #binding.pry
    if params.keys.include?("name")
      name = params["name"]
      render json: ItemSerializer.new(Item.find_by(name: name))
    elsif params.keys.include?("updated_at")
      updated_at = params["updated_at"]
      render json: ItemSerializer.new(Item.find_by(updated_at: updated_at))
    elsif params.keys.include?("id")
      id = params["id"]
      render json: ItemSerializer.new(Item.find(id))
    elsif params.keys.include?("description")
      description = params["description"]
      render json: ItemSerializer.new(Item.find_by(description: description))
    elsif params.keys.include?("unit_price")
      unit_price = params["unit_price"]
      render json: ItemSerializer.new(Item.find_by(unit_price: unit_price))
    elsif params.keys.include?("merchant_id")
      merchant_id = params["merchant_id"]
      render json: ItemSerializer.new(Item.find_by(merchant_id: merchant_id))
    else params.keys.include?("created_at")
      created_at = params["created_at"]
      render json: ItemSerializer.new(Item.find_by(created_at: created_at))
    end
  end
end
