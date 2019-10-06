class Api::V1::Customers::RandomController < ApplicationController

  def show
    customer = Customer.find(Customer.get_random_id)
    render json: CustomerSerializer.new(customer)
  end
end
