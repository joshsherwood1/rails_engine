require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(3)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it "sends specified top merchants by most revenue" do
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


    get "/api/v1/merchants/most_revenue?quantity=3"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    #binding.pry

    expect(merchants["data"].count).to eq(3)

    expect(merchants["data"].first["id"]).to eq(merchant_2.id.to_s)
    expect(merchants["data"][1]["id"]).to eq(merchant_4.id.to_s)
    expect(merchants["data"][2]["id"]).to eq(merchant_3.id.to_s)
  end

  it "finds single merchant record based on name" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde")
    merchant_2 = create(:merchant, name: "Klein, Rempel and Jones")
    merchant_3 = create(:merchant, name: "Willms and Sons")
    merchant_4 = create(:merchant, name: "Cummings-Thiel")
    merchant_5 = create(:merchant, name: "Williamson Group")
    merchant_6 = create(:merchant, name: "Williamson Group")

    get "/api/v1/merchants/find?name=Cummings-Thiel"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"]).to eq(merchant_4.id.to_s)
  end

  it "finds single merchant record based on updated_at attribute" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde", updated_at: "2012-03-27 14:53:59 UTC")
    merchant_2 = create(:merchant, name: "Klein, Rempel and Jones", updated_at: "2012-03-27 14:53:59 UTC")
    merchant_3 = create(:merchant, name: "Willms and Sons", updated_at: "2012-03-27 14:54:00 UTC")
    merchant_4 = create(:merchant, name: "Cummings-Thiel", updated_at: "2012-03-27 14:53:59 UTC")
    merchant_5 = create(:merchant, name: "Williamson Group", updated_at: "2012-03-27 14:53:59 UTC")
    merchant_6 = create(:merchant, name: "Williamson Group", updated_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/merchants/find?updated_at=2012-03-27 14:53:59 utC"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"]).to eq(merchant_1.id.to_s)
  end

  it "finds single merchant record based on created_at attribute" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC")
    merchant_2 = create(:merchant, name: "Klein, Rempel and Jones", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC")
    merchant_3 = create(:merchant, name: "Willms and Sons", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC")
    merchant_4 = create(:merchant, name: "Cummings-Thiel", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC")
    merchant_5 = create(:merchant, name: "Williamson Group", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC")
    merchant_6 = create(:merchant, name: "Williamson Group", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    get "/api/v1/merchants/find?created_at=2012-03-27 16:12:25 utc"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"]).to eq(merchant_6.id.to_s)
  end

  it "finds single merchant record based on id" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
    merchant_2 = create(:merchant, name: "Klein, Rempel and Jones", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 2)
    merchant_3 = create(:merchant, name: "Willms and Sons", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
    merchant_4 = create(:merchant, name: "Cummings-Thiel", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
    merchant_5 = create(:merchant, name: "Williamson Group", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
    merchant_6 = create(:merchant, name: "Williamson Group", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC", id: 6)

    get "/api/v1/merchants/find?id=2"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"]).to eq(merchant_2.id.to_s)
  end

  it "finds all merchant record matches based on name" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde")
    merchant_2 = create(:merchant, name: "Klein, Rempel and Jones")
    merchant_3 = create(:merchant, name: "Willms and Sons")
    merchant_4 = create(:merchant, name: "Cummings-Thiel")
    merchant_5 = create(:merchant, name: "Williamson Group")
    merchant_6 = create(:merchant, name: "Williamson Group")

    get "/api/v1/merchants/find_all?name=Williamson Group"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"].all? { |hash| hash["attributes"]["name"] == "Williamson Group" }).to eq(true)
  end

  it "finds all merchant record matches based on id" do
    merchant_1 = create(:merchant, id: 1)
    merchant_2 = create(:merchant, id: 2)
    merchant_3 = create(:merchant, id: 3)
    merchant_4 = create(:merchant, id: 4)
    merchant_5 = create(:merchant, id: 5)
    merchant_6 = create(:merchant, id: 6)

    get "/api/v1/merchants/find_all?id=2"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(1)
    expect(merchants["data"].all? { |hash| hash["attributes"]["id"] == 2 }).to eq(true)
  end

  it "finds all merchant record matches based on updated at" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde", updated_at: "2012-03-27 14:53:59 UTC")
    merchant_2 = create(:merchant, name: "Klein, Rempel and Jones", updated_at: "2012-03-27 14:53:59 UTC")
    merchant_3 = create(:merchant, name: "Willms and Sons", updated_at: "2012-03-27 14:54:00 UTC")
    merchant_4 = create(:merchant, name: "Cummings-Thiel", updated_at: "2012-03-27 14:53:59 UTC")
    merchant_5 = create(:merchant, name: "Williamson Group", updated_at: "2012-03-27 14:53:59 UTC")
    merchant_6 = create(:merchant, name: "Williamson Group", updated_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/merchants/find_all?updated_at=2012-03-27 14:53:59 UTC"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(5)
    expect(merchants["data"].all? { |hash| Time.parse(hash["attributes"]["updated_at"]) == "2012-03-27 14:53:59 UTC" }).to eq(true)
  end

  it "finds all merchant record matches based on created at" do
    merchant_1 = create(:merchant, name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC")
    merchant_2 = create(:merchant, name: "Klein, Rempel and Jones", created_at: "2012-03-27 14:53:59 UTC")
    merchant_3 = create(:merchant, name: "Willms and Sons", created_at: "2012-03-27 14:54:00 UTC")
    merchant_4 = create(:merchant, name: "Cummings-Thiel", created_at: "2012-03-27 14:53:59 UTC")
    merchant_5 = create(:merchant, name: "Williamson Group", created_at: "2012-03-27 14:53:59 UTC")
    merchant_6 = create(:merchant, name: "Williamson Group", created_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/merchants/find_all?created_at=2012-03-27 14:54:00 UTC"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(1)
    expect(merchants["data"].all? { |hash| Time.parse(hash["attributes"]["created_at"]) == "2012-03-27 14:54:00 UTC" }).to eq(true)
  end

  it "show all items belonging to a merchant" do
    customer_1 = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = create(:item, unit_price: 12345, merchant_id: merchant_2.id)
    item_2 = create(:item, unit_price: 22345, merchant_id: merchant_1.id)
    item_3 = create(:item, unit_price: 32345, merchant_id: merchant_1.id)
    item_4 = create(:item, unit_price: 42345, merchant_id: merchant_1.id)
    item_5 = create(:item, unit_price: 52345, merchant_id: merchant_1.id)
    item_6 = create(:item, unit_price: 62345, merchant_id: merchant_2.id)


    get "/api/v1/merchants/#{merchant_1.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(4)

    expect(items["data"].all? { |hash| hash["attributes"]["merchant_id"] == merchant_1.id }).to eq(true)
  end

  it "show all invoices belonging to a merchant" do
    customer_1 = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = create(:item, unit_price: 12345, merchant_id: merchant_2.id)
    item_2 = create(:item, unit_price: 22345, merchant_id: merchant_1.id)
    item_3 = create(:item, unit_price: 32345, merchant_id: merchant_1.id)
    item_4 = create(:item, unit_price: 42345, merchant_id: merchant_1.id)
    item_5 = create(:item, unit_price: 52345, merchant_id: merchant_1.id)
    item_6 = create(:item, unit_price: 62345, merchant_id: merchant_2.id)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
    invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
    invoice_4 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
    invoice_5 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
    invoice_6 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)

    get "/api/v1/merchants/#{merchant_2.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(4)

    expect(invoices["data"].all? { |hash| hash["attributes"]["merchant_id"] == merchant_2.id }).to eq(true)
  end

end
