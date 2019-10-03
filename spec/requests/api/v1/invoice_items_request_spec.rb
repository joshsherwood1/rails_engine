require 'rails_helper'

describe "Invoice Items API" do
  it "sends a list of invoice items" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item = create(:item, merchant_id: merchant.id)
    create_list(:invoice_item, 3, invoice_id: invoice.id, item_id: item.id)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
  end

  it "can get one invoice_item by its id" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant_id: merchant_1.id)
    customer_1 = create(:customer)
    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    id = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["id"]).to eq(id.to_s)
  end

  it "finds single invoice item record based on id" do
    customer_1 = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)
    merchant_5 = create(:merchant)
    merchant_6 = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
    invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_3.id)
    invoice_4 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_4.id)
    invoice_5 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_4.id)
    invoice_6 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_5.id)
    item_1 = create(:item, unit_price: 12345, merchant_id: merchant_5.id)
    item_2 = create(:item, unit_price: 22345, merchant_id: merchant_1.id)
    item_3 = create(:item, unit_price: 32345, merchant_id: merchant_2.id)
    item_4 = create(:item, unit_price: 42345, merchant_id: merchant_3.id)
    item_5 = create(:item, unit_price: 52345, merchant_id: merchant_4.id)
    item_6 = create(:item, unit_price: 62345, merchant_id: merchant_4.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_6.id, unit_price: item_1.unit_price, quantity: 1, id: 1, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, unit_price: item_2.unit_price, quantity: 1, id: 2, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id, unit_price: item_3.unit_price, quantity: 15, id: 3, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_4 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_3.id, unit_price: item_4.unit_price, quantity: 1, id: 4, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_5 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_4.id, unit_price: item_5.unit_price, quantity: 1, id: 5, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_5.id, unit_price: item_6.unit_price, quantity: 1, id: 6, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    get "/api/v1/invoice_items/find?id=4"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"]).to eq(invoice_item_4.id.to_s)
  end

  it "finds single invoice item record based on invoice_id" do
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
    item_1 = create(:item, unit_price: 12345, merchant_id: merchant_5.id)
    item_2 = create(:item, unit_price: 22345, merchant_id: merchant_1.id)
    item_3 = create(:item, unit_price: 32345, merchant_id: merchant_2.id)
    item_4 = create(:item, unit_price: 42345, merchant_id: merchant_3.id)
    item_5 = create(:item, unit_price: 52345, merchant_id: merchant_4.id)
    item_6 = create(:item, unit_price: 62345, merchant_id: merchant_4.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_6.id, unit_price: item_1.unit_price, quantity: 1, id: 1, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, unit_price: item_2.unit_price, quantity: 1, id: 2, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id, unit_price: item_3.unit_price, quantity: 15, id: 3, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_4 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_3.id, unit_price: item_4.unit_price, quantity: 1, id: 4, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_5 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_4.id, unit_price: item_5.unit_price, quantity: 1, id: 5, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_5.id, unit_price: item_6.unit_price, quantity: 1, id: 6, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    get "/api/v1/invoice_items/find?invoice_id=1"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"]).to eq(invoice_item_2.id.to_s)
  end

  it "finds single invoice item record based on item_id" do
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
    item_1 = create(:item, unit_price: 12345, merchant_id: merchant_5.id, id: 1)
    item_2 = create(:item, unit_price: 22345, merchant_id: merchant_1.id, id: 2)
    item_3 = create(:item, unit_price: 32345, merchant_id: merchant_2.id, id: 3)
    item_4 = create(:item, unit_price: 42345, merchant_id: merchant_3.id, id: 4)
    item_5 = create(:item, unit_price: 52345, merchant_id: merchant_4.id, id: 5)
    item_6 = create(:item, unit_price: 62345, merchant_id: merchant_4.id, id: 6)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_6.id, unit_price: item_1.unit_price, quantity: 1, id: 1, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, unit_price: item_2.unit_price, quantity: 1, id: 2, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id, unit_price: item_3.unit_price, quantity: 15, id: 3, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_4 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_3.id, unit_price: item_4.unit_price, quantity: 1, id: 4, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_5 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_4.id, unit_price: item_5.unit_price, quantity: 1, id: 5, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_5.id, unit_price: item_6.unit_price, quantity: 1, id: 6, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    get "/api/v1/invoice_items/find?item_id=5"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"]).to eq(invoice_item_5.id.to_s)
  end

  it "finds single invoice item record based on quantity" do
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
    item_1 = create(:item, unit_price: 12345, merchant_id: merchant_5.id, id: 1)
    item_2 = create(:item, unit_price: 22345, merchant_id: merchant_1.id, id: 2)
    item_3 = create(:item, unit_price: 32345, merchant_id: merchant_2.id, id: 3)
    item_4 = create(:item, unit_price: 42345, merchant_id: merchant_3.id, id: 4)
    item_5 = create(:item, unit_price: 52345, merchant_id: merchant_4.id, id: 5)
    item_6 = create(:item, unit_price: 62345, merchant_id: merchant_4.id, id: 6)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_6.id, unit_price: item_1.unit_price, quantity: 1, id: 1, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, unit_price: item_2.unit_price, quantity: 1, id: 2, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id, unit_price: item_3.unit_price, quantity: 15, id: 3, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_4 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_3.id, unit_price: item_4.unit_price, quantity: 1, id: 4, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_5 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_4.id, unit_price: item_5.unit_price, quantity: 1, id: 5, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_5.id, unit_price: item_6.unit_price, quantity: 1, id: 6, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    get "/api/v1/invoice_items/find?quantity=15"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"]).to eq(invoice_item_3.id.to_s)
  end

  it "finds single invoice item record based on unit_price" do
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
    item_1 = create(:item, unit_price: 12345, merchant_id: merchant_5.id, id: 1)
    item_2 = create(:item, unit_price: 22345, merchant_id: merchant_1.id, id: 2)
    item_3 = create(:item, unit_price: 32345, merchant_id: merchant_2.id, id: 3)
    item_4 = create(:item, unit_price: 42345, merchant_id: merchant_3.id, id: 4)
    item_5 = create(:item, unit_price: 52345, merchant_id: merchant_4.id, id: 5)
    item_6 = create(:item, unit_price: 62345, merchant_id: merchant_4.id, id: 6)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_6.id, unit_price: item_1.unit_price, quantity: 1, id: 1, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, unit_price: item_2.unit_price, quantity: 1, id: 2, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id, unit_price: item_3.unit_price, quantity: 15, id: 3, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_4 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_3.id, unit_price: item_4.unit_price, quantity: 1, id: 4, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_5 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_4.id, unit_price: item_5.unit_price, quantity: 1, id: 5, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_5.id, unit_price: item_6.unit_price, quantity: 1, id: 6, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    get "/api/v1/invoice_items/find?unit_price=22345"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"]).to eq(invoice_item_2.id.to_s)
  end

  it "finds single invoice item record based on updated_at" do
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
    item_1 = create(:item, unit_price: 12345, merchant_id: merchant_5.id, id: 1)
    item_2 = create(:item, unit_price: 22345, merchant_id: merchant_1.id, id: 2)
    item_3 = create(:item, unit_price: 32345, merchant_id: merchant_2.id, id: 3)
    item_4 = create(:item, unit_price: 42345, merchant_id: merchant_3.id, id: 4)
    item_5 = create(:item, unit_price: 52345, merchant_id: merchant_4.id, id: 5)
    item_6 = create(:item, unit_price: 62345, merchant_id: merchant_4.id, id: 6)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_6.id, unit_price: item_1.unit_price, quantity: 1, id: 1, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, unit_price: item_2.unit_price, quantity: 1, id: 2, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id, unit_price: item_3.unit_price, quantity: 15, id: 3, updated_at: "2012-03-22 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_4 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_3.id, unit_price: item_4.unit_price, quantity: 1, id: 4, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_5 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_4.id, unit_price: item_5.unit_price, quantity: 1, id: 5, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_5.id, unit_price: item_6.unit_price, quantity: 1, id: 6, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    get "/api/v1/invoice_items/find?updated_at=2012-03-22 14:53:59 UTC"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"]).to eq(invoice_item_3.id.to_s)
  end

  it "finds single invoice item record based on updated_at" do
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
    item_1 = create(:item, unit_price: 12345, merchant_id: merchant_5.id, id: 1)
    item_2 = create(:item, unit_price: 22345, merchant_id: merchant_1.id, id: 2)
    item_3 = create(:item, unit_price: 32345, merchant_id: merchant_2.id, id: 3)
    item_4 = create(:item, unit_price: 42345, merchant_id: merchant_3.id, id: 4)
    item_5 = create(:item, unit_price: 52345, merchant_id: merchant_4.id, id: 5)
    item_6 = create(:item, unit_price: 62345, merchant_id: merchant_4.id, id: 6)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_6.id, unit_price: item_1.unit_price, quantity: 1, id: 1, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, unit_price: item_2.unit_price, quantity: 1, id: 2, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id, unit_price: item_3.unit_price, quantity: 15, id: 3, updated_at: "2012-03-22 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_4 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_3.id, unit_price: item_4.unit_price, quantity: 1, id: 4, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-25 16:12:25 UTC")
    invoice_item_5 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_4.id, unit_price: item_5.unit_price, quantity: 1, id: 5, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_5.id, unit_price: item_6.unit_price, quantity: 1, id: 6, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    get "/api/v1/invoice_items/find?created_at=2012-03-25 16:12:25 UTC"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"]).to eq(invoice_item_4.id.to_s)
  end
end
