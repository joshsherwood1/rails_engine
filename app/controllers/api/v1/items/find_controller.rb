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
    else params.keys.include?("created_at")
      created_at = params["created_at"]
      render json: ItemSerializer.new(Item.find_by(created_at: created_at))
    end
  end
end
