class Api::V1::InvoiceItems::InvoiceController < ApplicationController

  def show
    @invoice_for_invoice_item = Invoice.find(InvoiceItem.find(params[:id]).invoice_id)
    render json: InvoiceSerializer.new(@invoice_for_invoice_item)
  end
end
