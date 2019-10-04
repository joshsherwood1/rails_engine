class Api::V1::Invoices::FindController < ApplicationController
  def show
    if params.keys.include?("status")
      status = params["status"]
      render json: InvoiceSerializer.new(Invoice.find_by(status: status))
    elsif params.keys.include?("updated_at")
      updated_at = params["updated_at"]
      render json: InvoiceSerializer.new(Invoice.find_by(updated_at: updated_at))
    elsif params.keys.include?("id")
      id = params["id"]
      render json: InvoiceSerializer.new(Invoice.find(id))
    elsif params.keys.include?("merchant_id")
      merchant_id = params["merchant_id"]
      render json: InvoiceSerializer.new(Invoice.find_by(merchant_id: merchant_id))
    elsif params.keys.include?("customer_id")
      customer_id = params["customer_id"]
      render json: InvoiceSerializer.new(Invoice.find_by(customer_id: customer_id))
    else params.keys.include?("created_at")
      created_at = params["created_at"]
      render json: InvoiceSerializer.new(Invoice.find_by(created_at: created_at))
    end
  end

  def index
    if params.keys.include?("status")
      render json: InvoiceFindAllSerializer.new(Invoice.find_by_status(params["status"]))
    elsif params.keys.include?("updated_at")
      invocies = Invoice.find_by_updated_at(params["updated_at"])
      render json: InvoiceFindAllSerializer.new(invocies)
    elsif params.keys.include?("created_at")
      invocies = Invoice.find_by_created_at(params["created_at"])
      render json: InvoiceFindAllSerializer.new(invocies)
    elsif params.keys.include?("merchant_id")
      invocies = Invoice.find_by_merchant_id(params["merchant_id"])
      render json: InvoiceFindAllSerializer.new(invocies)
    elsif params.keys.include?("customer_id")
      invocies = Invoice.find_by_customer_id(params["customer_id"])
      render json: InvoiceFindAllSerializer.new(invocies)
    else params.keys.include?("id")
      render json: InvoiceFindAllSerializer.new(Invoice.find_by_id(params["id"]))
    end
  end

end
