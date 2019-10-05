class Api::V1::Invoices::TransactionsController < ApplicationController

  def index
    @transactions_for_invoice = Invoice.find(params[:id]).transactions
    render json: TransactionSerializer.new(@transactions_for_invoice)
  end
end
