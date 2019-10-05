class Api::V1::Merchants::InvoicesController < ApplicationController

  def index
    @invoices_for_merchant = Merchant.find(params[:id]).invoices
    render json: InvoiceSerializer.new(@invoices_for_merchant)
  end
end
