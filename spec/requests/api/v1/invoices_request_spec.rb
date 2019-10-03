require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    customer = create(:customer)
    merchant = create(:merchant)
    create_list(:invoice, 3, merchant_id: merchant.id, customer_id: customer.id)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
  end

  it "can get one invoice by its id" do
    merchant_1 = create(:merchant)
    customer_1 = create(:customer)
    id = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"]).to eq(id.to_s)
  end

  it "finds single invoice record based on id" do
    customer_1 = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)
    merchant_5 = create(:merchant)
    merchant_6 = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id, id: 1)
    invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id, id: 2)
    invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_3.id, id: 3)
    invoice_4 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_4.id, id: 4)
    invoice_5 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_4.id, id: 5)
    invoice_6 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_5.id, id: 6)

    get "/api/v1/invoices/find?id=2"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"]).to eq(invoice_2.id.to_s)
  end

  it "finds single invoice record based on merchant id" do
    customer_1 = create(:customer)
    merchant_1 = create(:merchant, id: 1)
    merchant_2 = create(:merchant, id: 2)
    merchant_3 = create(:merchant, id: 3)
    merchant_4 = create(:merchant, id: 4)
    merchant_5 = create(:merchant, id: 5)
    merchant_6 = create(:merchant, id: 6)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id, id: 1)
    invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id, id: 2)
    invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_3.id, id: 3)
    invoice_4 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_4.id, id: 4)
    invoice_5 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_4.id, id: 5)
    invoice_6 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_5.id, id: 6)

    get "/api/v1/invoices/find?merchant_id=3"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"]).to eq(invoice_3.id.to_s)
  end

  it "finds single invoice record based on customer id" do
    customer_1 = create(:customer, id: 1)
    merchant_1 = create(:merchant, id: 1)
    merchant_2 = create(:merchant, id: 2)
    merchant_3 = create(:merchant, id: 3)
    merchant_4 = create(:merchant, id: 4)
    merchant_5 = create(:merchant, id: 5)
    merchant_6 = create(:merchant, id: 6)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id, id: 1)
    invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id, id: 2)
    invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_3.id, id: 3)
    invoice_4 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_4.id, id: 4)
    invoice_5 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_4.id, id: 5)
    invoice_6 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_5.id, id: 6)

    get "/api/v1/invoices/find?customer_id=1"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"]).to eq(invoice_1.id.to_s)
  end
end
