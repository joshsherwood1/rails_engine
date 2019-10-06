class Api::V1::Items::FindController < ApplicationController
  def show
    #binding.pry
    if params.keys.include?("name")
      name = params["name"]
      item = Item.find_first_item_by_name(name)
      render json: ItemSerializer.new(item)
    elsif params.keys.include?("updated_at")
      updated_at = params["updated_at"]
      render json: ItemSerializer.new(Item.find_by(updated_at: updated_at))
    elsif params.keys.include?("id")
      id = params["id"]
      render json: ItemSerializer.new(Item.find(id))
    elsif params.keys.include?("description")
      description = params["description"]
      item = Item.find_first_item_by_description(description)
      render json: ItemSerializer.new(item)
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

  def index
    if params.keys.include?("name")
      render json: ItemFindAllSerializer.new(Item.find_by_name(params["name"]))
    elsif params.keys.include?("updated_at")
      items = Item.find_by_updated_at(params["updated_at"])
      render json: ItemFindAllSerializer.new(items)
    elsif params.keys.include?("created_at")
      items = Item.find_by_created_at(params["created_at"])
      render json: ItemFindAllSerializer.new(items)
    elsif params.keys.include?("merchant_id")
      items = Item.find_by_merchant_id(params["merchant_id"])
      render json: ItemFindAllSerializer.new(items)
    elsif params.keys.include?("description")
      items = Item.find_by_description(params["description"])
      render json: ItemFindAllSerializer.new(items)
    elsif params.keys.include?("unit_price")
      items = Item.find_by_unit_price(params["unit_price"])
      render json: ItemFindAllSerializer.new(items)
    else params.keys.include?("id")
      render json: ItemFindAllSerializer.new(Item.find_by_id(params["id"]))
    end
  end
end
