class Api::V1::Items::BestDayController < ApplicationController
  def show
    item = Item.find(params[:id])
    item.find_best_day
  end
end
