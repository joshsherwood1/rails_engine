class Api::V1::Customers::FindController < ApplicationController
  def show
    if params.keys.include?("first_name")
      first_name = params["first_name"]
      render json: CustomerSerializer.new(Customer.find_by(first_name: first_name))
    elsif params.keys.include?("updated_at")
      updated_at = params["updated_at"]
      render json: CustomerSerializer.new(Customer.find_by(updated_at: updated_at))
    elsif params.keys.include?("id")
      id = params["id"]
      render json: CustomerSerializer.new(Customer.find(id))
    elsif params.keys.include?("last_name")
      last_name = params["last_name"]
      render json: CustomerSerializer.new(Customer.find_by(last_name: last_name))
    else params.keys.include?("created_at")
      created_at = params["created_at"]
      render json: CustomerSerializer.new(Customer.find_by(created_at: created_at))
    end
  end
end
