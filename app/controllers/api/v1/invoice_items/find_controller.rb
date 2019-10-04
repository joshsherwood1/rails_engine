class Api::V1::InvoiceItems::FindController < ApplicationController
  def show
    if params.keys.include?("item_id")
      item_id = params["item_id"]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(item_id: item_id))
    elsif params.keys.include?("updated_at")
      updated_at = params["updated_at"]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(updated_at: updated_at))
    elsif params.keys.include?("id")
      id = params["id"]
      render json: InvoiceItemSerializer.new(InvoiceItem.find(id))
    elsif params.keys.include?("invoice_id")
      invoice_id = params["invoice_id"]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_id: invoice_id))
    elsif params.keys.include?("unit_price")
      unit_price = params["unit_price"]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(unit_price: unit_price))
    elsif params.keys.include?("quantity")
      quantity = params["quantity"]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(quantity: quantity))
    else params.keys.include?("created_at")
      created_at = params["created_at"]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(created_at: created_at))
    end
  end

  def index
    if params.keys.include?("unit_price")
      render json: InvoiceItemFindAllSerializer.new(InvoiceItem.find_by_unit_price(params["unit_price"]))
    elsif params.keys.include?("updated_at")
      invocies = InvoiceItem.find_by_updated_at(params["updated_at"])
      render json: InvoiceItemFindAllSerializer.new(invocies)
    elsif params.keys.include?("created_at")
      invocies = InvoiceItem.find_by_created_at(params["created_at"])
      render json: InvoiceItemFindAllSerializer.new(invocies)
    elsif params.keys.include?("invoice_id")
      invocies = InvoiceItem.find_by_invoice_id(params["invoice_id"])
      render json: InvoiceItemFindAllSerializer.new(invocies)
    elsif params.keys.include?("item_id")
      invocies = InvoiceItem.find_by_item_id(params["item_id"])
      render json: InvoiceItemFindAllSerializer.new(invocies)
    elsif params.keys.include?("quantity")
      invocies = InvoiceItem.find_by_quantity(params["quantity"])
      render json: InvoiceItemFindAllSerializer.new(invocies)
    else params.keys.include?("id")
      render json: InvoiceItemFindAllSerializer.new(InvoiceItem.find_by_id(params["id"]))
    end
  end
end
