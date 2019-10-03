class Api::V1::Transactions::FindController < ApplicationController
  def show
    #binding.pry
    if params.keys.include?("invoice_id")
      name = params["name"]
      render json: TransactionSerializer.new(Transaction.find_by(name: name))
    elsif params.keys.include?("updated_at")
      updated_at = params["updated_at"]
      render json: TransactionSerializer.new(Transaction.find_by(updated_at: updated_at))
    elsif params.keys.include?("credit_card_number")
      credit_card_number = params["credit_card_number"]
      render json: TransactionSerializer.new(Transaction.find_by(credit_card_number: credit_card_number))
    elsif params.keys.include?("credit_card_expiration_date")
      credit_card_expiration_date = params["credit_card_expiration_date"]
      render json: TransactionSerializer.new(Transaction.find_by(credit_card_expiration_date: credit_card_expiration_date))
    elsif params.keys.include?("result")
      result = params["result"]
      render json: TransactionSerializer.new(Transaction.find_by(result: result))
    elsif params.keys.include?("id")
      id = params["id"]
      render json: TransactionSerializer.new(Transaction.find(id))
    else params.keys.include?("created_at")
      created_at = params["created_at"]
      render json: TransactionSerializer.new(Transaction.find_by(created_at: created_at))
    end
  end
end
