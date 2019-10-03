require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
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
end
