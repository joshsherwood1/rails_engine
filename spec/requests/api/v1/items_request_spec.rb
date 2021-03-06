require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(9)
  end

  it "can get one item by its id" do
    merchant_1 = create(:merchant)
    id = create(:item, merchant_id: merchant_1.id).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"]).to eq(id.to_s)
  end

  it "finds single item record based on name" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde")
    item_1 = create(:item, name: "Item Qui Esse", merchant_id: merchant_1.id)
    item_2 = create(:item, name: "Item Qui Essei", merchant_id: merchant_1.id)
    item_3 = create(:item, name: "Item Qui Esseie", merchant_id: merchant_1.id)
    item_4 = create(:item, name: "Item Qui Esseia", merchant_id: merchant_1.id)
    item_5 = create(:item, name: "Item Qui Esseii", merchant_id: merchant_1.id)
    item_6 = create(:item, name: "Item Qui Esseiu", merchant_id: merchant_1.id)

    get "/api/v1/items/find?name=Item Qui Esseii"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"]).to eq(item_5.id.to_s)
  end

  it "finds single item record based on id" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde")
    item_1 = create(:item, name: "Item Qui Esse", merchant_id: merchant_1.id, id: 1)
    item_2 = create(:item, name: "Item Qui Essei", merchant_id: merchant_1.id, id: 2)
    item_3 = create(:item, name: "Item Qui Esseie", merchant_id: merchant_1.id, id: 3)
    item_4 = create(:item, name: "Item Qui Esseia", merchant_id: merchant_1.id, id: 4)
    item_5 = create(:item, name: "Item Qui Esseii", merchant_id: merchant_1.id, id: 5)
    item_6 = create(:item, name: "Item Qui Esseiu", merchant_id: merchant_1.id, id: 6)

    get "/api/v1/items/find?id=6"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"]).to eq(item_6.id.to_s)
  end

  it "finds single item record based on created_at attribute" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde")
    item_1 = create(:item, name: "Item Qui Esse", merchant_id: merchant_1.id, id: 1, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:21 UTC")
    item_2 = create(:item, name: "Item Qui Essei", merchant_id: merchant_1.id, id: 2, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    item_3 = create(:item, name: "Item Qui Esseie", merchant_id: merchant_1.id, id: 3, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    item_4 = create(:item, name: "Item Qui Esseia", merchant_id: merchant_1.id, id: 4, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    item_5 = create(:item, name: "Item Qui Esseii", merchant_id: merchant_1.id, id: 5, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    item_6 = create(:item, name: "Item Qui Esseiu", merchant_id: merchant_1.id, id: 6, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    get "/api/v1/items/find?created_at=2012-03-27 16:12:21 UTC"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"]).to eq(item_1.id.to_s)
  end

  it "finds single item record based on updated_at attribute" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde")
    item_1 = create(:item, name: "Item Qui Esse", merchant_id: merchant_1.id, id: 1, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:21 UTC")
    item_2 = create(:item, name: "Item Qui Essei", merchant_id: merchant_1.id, id: 2, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    item_3 = create(:item, name: "Item Qui Esseie", merchant_id: merchant_1.id, id: 3, updated_at: "2012-03-28 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    item_4 = create(:item, name: "Item Qui Esseia", merchant_id: merchant_1.id, id: 4, updated_at: "2012-03-28 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    item_5 = create(:item, name: "Item Qui Esseii", merchant_id: merchant_1.id, id: 5, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    item_6 = create(:item, name: "Item Qui Esseiu", merchant_id: merchant_1.id, id: 6, updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    get "/api/v1/items/find?updated_at=2012-03-28 14:53:59 UTC"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"]).to eq(item_3.id.to_s)
  end

  it "finds single item record based on merchant_id" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde", id: 1)
    merchant_2 = create(:merchant, name: "Schroeder", id: 2)
    item_1 = create(:item, name: "Item Qui Esse", merchant_id: merchant_2.id)
    item_2 = create(:item, name: "Item Qui Essei", merchant_id: merchant_2.id)
    item_3 = create(:item, name: "Item Qui Esseie", merchant_id: merchant_2.id)
    item_4 = create(:item, name: "Item Qui Esseia", merchant_id: merchant_1.id)
    item_5 = create(:item, name: "Item Qui Esseii", merchant_id: merchant_1.id)
    item_6 = create(:item, name: "Item Qui Esseiu", merchant_id: merchant_1.id)

    get "/api/v1/items/find?merchant_id=1"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"]).to eq(item_4.id.to_s)
  end

  it "finds single item record based on description" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde", id: 1)
    merchant_2 = create(:merchant, name: "Schroeder", id: 2)
    item_1 = create(:item, description: "Item Qui Esse", merchant_id: merchant_2.id)
    item_2 = create(:item, description: "Item Qui Essei", merchant_id: merchant_2.id)
    item_3 = create(:item, description: "Item Qui Esseie", merchant_id: merchant_2.id)
    item_4 = create(:item, description: "Item Qui Esseia", merchant_id: merchant_1.id)
    item_5 = create(:item, description: "Item Qui Esseii", merchant_id: merchant_1.id)
    item_6 = create(:item, description: "Item Qui Esseiu", merchant_id: merchant_1.id)

    get "/api/v1/items/find?description=Item Qui Essei"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"]).to eq(item_2.id.to_s)
  end

  it "finds single item record based on unit price" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde", id: 1)
    merchant_2 = create(:merchant, name: "Schroeder", id: 2)
    item_1 = create(:item, unit_price: 12344, merchant_id: merchant_2.id)
    item_2 = create(:item, unit_price: 12344, merchant_id: merchant_2.id)
    item_3 = create(:item, unit_price: 22344, merchant_id: merchant_2.id)
    item_4 = create(:item, unit_price: 32344, merchant_id: merchant_1.id)
    item_5 = create(:item, unit_price: 123443, merchant_id: merchant_1.id)
    item_6 = create(:item, unit_price: 1234455, merchant_id: merchant_1.id)

    get "/api/v1/items/find?unit_price=22344"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"]).to eq(item_3.id.to_s)
  end

  it "finds all item record matches based on merchant_id" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde", id: 1)
    merchant_2 = create(:merchant, name: "Schroeder", id: 2)
    item_1 = create(:item, unit_price: 12344, merchant_id: merchant_2.id)
    item_2 = create(:item, unit_price: 12344, merchant_id: merchant_2.id)
    item_3 = create(:item, unit_price: 22344, merchant_id: merchant_2.id)
    item_4 = create(:item, unit_price: 32344, merchant_id: merchant_1.id)
    item_5 = create(:item, unit_price: 123443, merchant_id: merchant_1.id)
    item_6 = create(:item, unit_price: 1234455, merchant_id: merchant_1.id)

    get "/api/v1/items/find_all?merchant_id=2"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
    #binding.pry
    expect(items["data"].all? { |hash| hash["attributes"]["merchant_id"] == 2 }).to eq(true)
  end

  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
    @item_1 = create(:item, unit_price: 12345, merchant_id: @merchant_5.id, name: "Esso Dei", id: 123456789, description: "great!", updated_at: "2012-02-27 15:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC")
    @item_2 = create(:item, unit_price: 22345, merchant_id: @merchant_1.id, name: "Esso Deii", id: 223456789, description: "great!!", updated_at: "2012-02-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC")
    @item_3 = create(:item, unit_price: 32345, merchant_id: @merchant_2.id, name: "Esso Deia", id: 323456789, description: "greater!", updated_at: "2012-02-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC")
    @item_4 = create(:item, unit_price: 42345, merchant_id: @merchant_3.id, name: "Esso Deia", id: 423456789, description: "greatest!", updated_at: "2012-02-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC")
    @item_5 = create(:item, unit_price: 52345, merchant_id: @merchant_4.id, name: "Esso Deio", id: 523456789, description: "best!", updated_at: "2012-02-27 14:53:59 UTC", created_at: "2012-03-27 14:54:59 UTC")
    @item_6 = create(:item, unit_price: 62345, merchant_id: @merchant_4.id, name: "Esso Deiu", id: 623456789, description: "good!", updated_at: "2012-02-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC")
  end

  it "finds all item record matches based on name" do

    get "/api/v1/items/find_all?name=Esso Deii"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(1)

    expect(items["data"].all? { |hash| hash["attributes"]["name"] == "Esso Deii" }).to eq(true)
  end

  it "finds all item record matches based on description" do

    get "/api/v1/items/find_all?description=best!"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(1)
    expect(items["data"].all? { |hash| hash["attributes"]["description"] == "best!" }).to eq(true)
  end

  it "finds all item record matches based on id" do

    get "/api/v1/items/find_all?id=423456789"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(1)
    expect(items["data"].all? { |hash| hash["attributes"]["id"] == 423456789 }).to eq(true)
  end

  it "finds all item record matches based on unit_price" do

    get "/api/v1/items/find_all?unit_price=32345"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(1)
    expect(items["data"].all? { |hash| hash["attributes"]["unit_price"] == "323.45" }).to eq(true)
  end

  it "finds all item record matches based on created_at" do

    get "/api/v1/items/find_all?created_at=2012-03-27 14:53:59 UTC"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(5)
    expect(items["data"].all? { |hash| Time.parse(hash["attributes"]["created_at"]) == "2012-03-27 14:53:59 UTC" }).to eq(true)
  end

  it "finds all item record matches based on updated_at" do

    get "/api/v1/items/find_all?updated_at=2012-02-27 14:53:59 UTC"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(5)
    expect(items["data"].all? { |hash| Time.parse(hash["attributes"]["updated_at"]) == "2012-02-27 14:53:59 UTC" }).to eq(true)
  end

  it "sends a random item" do
    merchant = create(:merchant)
    create_list(:item, 10, merchant_id: merchant.id)

    get "/api/v1/items/random"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["attributes"].count).to eq(5)
  end

  it "sends specified top items by most revenue" do
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
    create(:invoice_item, item_id: item_1.id, invoice_id: invoice_6.id, unit_price: item_1.unit_price, quantity: 1)
    create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, unit_price: item_2.unit_price, quantity: 1)
    create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id, unit_price: item_3.unit_price, quantity: 15)
    create(:invoice_item, item_id: item_4.id, invoice_id: invoice_3.id, unit_price: item_4.unit_price, quantity: 1)
    create(:invoice_item, item_id: item_5.id, invoice_id: invoice_4.id, unit_price: item_5.unit_price, quantity: 1)
    create(:invoice_item, item_id: item_6.id, invoice_id: invoice_5.id, unit_price: item_6.unit_price, quantity: 1)
    create(:transaction, invoice_id: invoice_1.id, result: "success")
    create(:transaction, invoice_id: invoice_2.id, result: "success")
    create(:transaction, invoice_id: invoice_3.id, result: "success")
    create(:transaction, invoice_id: invoice_4.id, result: "success")
    create(:transaction, invoice_id: invoice_5.id, result: "success")
    create(:transaction, invoice_id: invoice_6.id, result: "success")


    get "/api/v1/items/most_revenue?quantity=3"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)

    expect(items["data"].first["id"]).to eq(item_3.id.to_s)
    expect(items["data"][1]["id"]).to eq(item_6.id.to_s)
    expect(items["data"][2]["id"]).to eq(item_5.id.to_s)
  end

  it "returns the date with the most sales for the given item using the invoice date" do
    customer_1 = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)
    merchant_5 = create(:merchant)
    merchant_6 = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id, updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id, updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_3.id, updated_at: "2012-03-28 16:12:25 UTC", created_at: "2012-03-28 16:12:25 UTC")
    invoice_4 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_4.id, updated_at: "2012-03-28 16:12:25 UTC", created_at: "2012-03-28 16:12:25 UTC")
    invoice_5 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_4.id, updated_at: "2012-03-29 16:12:25 UTC", created_at: "2012-03-29 16:12:25 UTC")
    invoice_6 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_5.id, updated_at: "2012-03-29 16:12:25 UTC", created_at: "2012-03-29 16:12:25 UTC")
    item_1 = create(:item, unit_price: 12345, merchant_id: merchant_5.id, updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    item_2 = create(:item, unit_price: 22345, merchant_id: merchant_1.id, updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    create(:invoice_item, item_id: item_1.id, invoice_id: invoice_6.id, unit_price: item_1.unit_price, quantity: 1, updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    create(:invoice_item, item_id: item_2.id, invoice_id: invoice_1.id, unit_price: item_2.unit_price, quantity: 1, updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    create(:invoice_item, item_id: item_1.id, invoice_id: invoice_3.id, unit_price: item_1.unit_price, quantity: 15, updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, unit_price: item_2.unit_price, quantity: 1, updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    create(:invoice_item, item_id: item_1.id, invoice_id: invoice_4.id, unit_price: item_1.unit_price, quantity: 1, updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    create(:invoice_item, item_id: item_2.id, invoice_id: invoice_5.id, unit_price: item_2.unit_price, quantity: 1, updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    create(:transaction, invoice_id: invoice_1.id, result: "success", updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    create(:transaction, invoice_id: invoice_2.id, result: "success", updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    create(:transaction, invoice_id: invoice_3.id, result: "success", updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    create(:transaction, invoice_id: invoice_4.id, result: "success", updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    create(:transaction, invoice_id: invoice_5.id, result: "success", updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")
    create(:transaction, invoice_id: invoice_6.id, result: "success", updated_at: "2012-03-27 16:12:25 UTC", created_at: "2012-03-27 16:12:25 UTC")


    get "/api/v1/items/#{item_1.id}/best_day"

    expect(response).to be_successful

    date = JSON.parse(response.body)

    expect(date["data"]["attributes"]["best_day"]).to eq("2012-03-28")

    #expect(date["data"].first["id"]).to eq(item_3.id.to_s)
  end
end
