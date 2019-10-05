class Api::V1::Customers::TransactionsController < ApplicationController

  def index
    @transactions_for_customer = Customer.find(params[:id]).transactions
    render json: TransactionSerializer.new(@transactions_for_customer)
  end
end
