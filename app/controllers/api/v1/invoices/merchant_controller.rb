class Api::V1::Invoices::MerchantController < ApplicationController

  def show
    @merchant_for_invoice = Merchant.find(Invoice.find(params[:id]).merchant_id)
    render json: MerchantFindSerializer.new(@merchant_for_invoice)
  end
end
