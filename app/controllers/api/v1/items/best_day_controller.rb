class Api::V1::Items::BestDayController < ApplicationController
  def show
    item = Item.find(params[:id])
    invoices = item.find_best_day
    date = invoices.first.created_at.to_date.to_s
    render json: DateSerializer.new(date).json
  end
end
