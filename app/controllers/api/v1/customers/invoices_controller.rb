class Api::V1::Customers::InvoicesController < ApplicationController

  def index
    @invoices_for_customer = Customer.find(params[:id]).invoices
    render json: InvoiceSerializer.new(@invoices_for_customer)
  end
end
