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
end
