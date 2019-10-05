class Api::V1::Invoices::MerchantController < ApplicationController

  def index
    @merchant_for_invoice = Merchant.find(Invoice.find(params[:id]).merchant_id)
    render json: MerchantSerializer.new(@merchant_for_invoice)
  end
end
