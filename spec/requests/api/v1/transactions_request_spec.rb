require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    create_list(:transaction, 3, invoice_id: invoice.id)

    get "/api/v1/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(3)
  end

  it "can get one transaction by its id" do
    merchant_1 = create(:merchant)
    customer_1 = create(:customer)
    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    id = create(:transaction, invoice_id: invoice_1.id).id

    get "/api/v1/transactions/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"]).to eq(id.to_s)
  end
end
