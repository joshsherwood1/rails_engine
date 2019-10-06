class Api::V1::Transactions::RandomController < ApplicationController

  def show
    transaction = Transaction.find(Transaction.get_random_id)
    render json: TransactionSerializer.new(transaction)
  end
end
