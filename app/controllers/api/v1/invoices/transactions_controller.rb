class Api::V1::Invoices::TransactionsController < ApplicationController

  def index
    @transactions_for_merchant = Invoice.find(params[:id]).transactions
    render json: TransactionSerializer.new(@transactions_for_merchant)
  end
end
