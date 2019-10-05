class Api::V1::Invoices::RandomController < ApplicationController

  def show
    item = Invoice.find(Invoice.get_random_id)
    render json: InvoiceSerializer.new(item)
  end
end
