class Api::V1::Invoices::CustomerController < ApplicationController

  def index
    @customer_for_invoice = Customer.find(Invoice.find(params[:id]).customer_id)
    render json: CustomerSerializer.new(@customer_for_invoice)
  end
end
