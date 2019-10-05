class Api::V1::Transactions::InvoiceController < ApplicationController

  def show
    @invoice_for_transaction = Invoice.find(Transaction.find(params[:id]).invoice_id)
    render json: InvoiceSerializer.new(@invoice_for_transaction)
  end
end
