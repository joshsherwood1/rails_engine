class Api::V1::Transactions::FindController < ApplicationController
  def show
    #binding.pry
    if params.keys.include?("invoice_id")
      invoice_id = params["invoice_id"]
      render json: TransactionSerializer.new(Transaction.find_by(invoice_id: invoice_id))
    elsif params.keys.include?("updated_at")
      updated_at = params["updated_at"]
      render json: TransactionSerializer.new(Transaction.find_by(updated_at: updated_at))
    elsif params.keys.include?("credit_card_number")
      credit_card_number = params["credit_card_number"]
      transaction = Transaction.find_by(credit_card_number: credit_card_number)
      render json: TransactionSerializer.new(transaction)
    elsif params.keys.include?("credit_card_expiration_date")
      credit_card_expiration_date = params["credit_card_expiration_date"]
      transaction = Transaction.find_by(credit_card_expiration_date: credit_card_expiration_date)
      render json: TransactionSerializer.new(transaction)
    elsif params.keys.include?("result")
      result = params["result"]
      transaction = Transaction.find_by("LOWER(result) = ?", result.downcase)
      render json: TransactionSerializer.new(transaction)
    elsif params.keys.include?("id")
      id = params["id"]
      render json: TransactionSerializer.new(Transaction.find(id))
    else params.keys.include?("created_at")
      created_at = params["created_at"]
      render json: TransactionSerializer.new(Transaction.find_by(created_at: created_at))
    end
  end

  def index
    if params.keys.include?("invoice_id")
      render json: TransactionFindAllSerializer.new(Transaction.find_by_invoice_id(params["invoice_id"]))
    elsif params.keys.include?("updated_at")
      transactions = Transaction.find_by_updated_at(params["updated_at"])
      render json: TransactionFindAllSerializer.new(transactions)
    elsif params.keys.include?("created_at")
      transactions = Transaction.find_by_created_at(params["created_at"])
      render json: TransactionFindAllSerializer.new(transactions)
    elsif params.keys.include?("credit_card_number")
      transactions = Transaction.find_by_credit_card_number(params["credit_card_number"])
      render json: TransactionFindAllSerializer.new(transactions)
    elsif params.keys.include?("credit_card_expiration_date")
      transactions = Transaction.find_by_credit_card_expiration_date(params["credit_card_expiration_date"])
      render json: TransactionFindAllSerializer.new(transactions)
    elsif params.keys.include?("result")
      transactions = Transaction.find_by_result(params["result"])
      render json: TransactionFindAllSerializer.new(transactions)
    else params.keys.include?("id")
      render json: TransactionFindAllSerializer.new(Transaction.find_by_id(params["id"]))
    end
  end
end
