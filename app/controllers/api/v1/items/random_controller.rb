class Api::V1::Items::RandomController < ApplicationController

  def show
    item = Item.find(Item.get_random_id)
    render json: ItemSerializer.new(item)
  end
end
