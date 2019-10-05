class Api::V1::Invoices::InvoiceItemsController < ApplicationController

  def index
    @invoice_items_for_invoice = Invoice.find(params[:id]).invoice_items
    render json: InvoiceItemSerializer.new(@invoice_items_for_invoice)
  end
end
