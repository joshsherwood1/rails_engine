class Api::V1::InvoiceItems::ItemController < ApplicationController

  def index
    @item_for_invoice_item = Item.find(InvoiceItem.find(params[:id]).item_id)
    render json: ItemSerializer.new(@item_for_invoice_item)
  end
end
