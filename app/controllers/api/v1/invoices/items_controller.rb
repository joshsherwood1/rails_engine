class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    @items_for_invoice = Invoice.find(params[:id]).items
    render json: ItemSerializer.new(@items_for_invoice)
  end
end
