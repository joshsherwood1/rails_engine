require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do

    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(3)

  end

  it "can get one customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"]).to eq(id.to_s)
  end

  it "finds single customer record based on id" do
    customer_1 = create(:customer, last_name: "Smith", first_name: "Will", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
    customer_2 = create(:customer, last_name: "Smit", first_name: "Jill", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 2)
    customer_3 = create(:customer, last_name: "Carpenter", first_name: "Rick", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
    customer_4 = create(:customer, last_name: "Travers", first_name: "Al", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
    customer_5 = create(:customer, last_name: "Beck", first_name: "Dante", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
    customer_6 = create(:customer, last_name: "Bee", first_name: "Lila", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC", id: 6)

    get "/api/v1/customers/find?id=2"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"]).to eq(customer_2.id.to_s)
  end

  it "finds single customer record based on first_name" do
    customer_1 = create(:customer, last_name: "Smith", first_name: "Will", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
    customer_2 = create(:customer, last_name: "Smit", first_name: "Jill", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 2)
    customer_3 = create(:customer, last_name: "Carpenter", first_name: "Rick", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
    customer_4 = create(:customer, last_name: "Travers", first_name: "Al", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
    customer_5 = create(:customer, last_name: "Beck", first_name: "Dante", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
    customer_6 = create(:customer, last_name: "Bee", first_name: "Lila", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC", id: 6)

    get "/api/v1/customers/find?first_name=Jill"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"]).to eq(customer_2.id.to_s)
  end

  it "finds single customer record based on last_name" do
    customer_1 = create(:customer, last_name: "Smith", first_name: "Will", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
    customer_2 = create(:customer, last_name: "Smit", first_name: "Jill", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 2)
    customer_3 = create(:customer, last_name: "Carpenter", first_name: "Rick", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
    customer_4 = create(:customer, last_name: "Travers", first_name: "Al", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
    customer_5 = create(:customer, last_name: "Beck", first_name: "Dante", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
    customer_6 = create(:customer, last_name: "Bee", first_name: "Lila", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC", id: 6)

    get "/api/v1/customers/find?last_name=Bee"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"]).to eq(customer_6.id.to_s)
  end

  it "finds single customer record based on updated_at" do
    customer_1 = create(:customer, last_name: "Smith", first_name: "Will", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
    customer_2 = create(:customer, last_name: "Smit", first_name: "Jill", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 2)
    customer_3 = create(:customer, last_name: "Carpenter", first_name: "Rick", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
    customer_4 = create(:customer, last_name: "Travers", first_name: "Al", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
    customer_5 = create(:customer, last_name: "Beck", first_name: "Dante", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
    customer_6 = create(:customer, last_name: "Bee", first_name: "Lila", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC", id: 6)

    get "/api/v1/customers/find?updated_at=2012-03-27 14:54:00 UTC"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"]).to eq(customer_3.id.to_s)
  end

  it "finds single customer record based on created_at" do
    customer_1 = create(:customer, last_name: "Smith", first_name: "Will", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
    customer_2 = create(:customer, last_name: "Smit", first_name: "Jill", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 2)
    customer_3 = create(:customer, last_name: "Carpenter", first_name: "Rick", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
    customer_4 = create(:customer, last_name: "Travers", first_name: "Al", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
    customer_5 = create(:customer, last_name: "Beck", first_name: "Dante", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
    customer_6 = create(:customer, last_name: "Bee", first_name: "Lila", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC", id: 6)

    get "/api/v1/customers/find?created_at=2012-03-27 16:12:25 UTC"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"]).to eq(customer_6.id.to_s)
  end

  it "finds all customer record matches based on first name" do
    customer_1 = create(:customer, last_name: "Smith", first_name: "Will", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
    customer_2 = create(:customer, last_name: "Smit", first_name: "Jill", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 2)
    customer_3 = create(:customer, last_name: "Carpenter", first_name: "Rick", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
    customer_4 = create(:customer, last_name: "Travers", first_name: "Al", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
    customer_5 = create(:customer, last_name: "Beck", first_name: "Dante", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
    customer_6 = create(:customer, last_name: "Bee", first_name: "Lila", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC", id: 6)

    get "/api/v1/customers/find_all?first_name=Dante"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(1)
    expect(customers["data"].all? { |hash| hash["attributes"]["first_name"] == "Dante" }).to eq(true)
  end

  it "finds all customer record matches based on last name" do
    customer_1 = create(:customer, last_name: "Smith", first_name: "Will", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
    customer_2 = create(:customer, last_name: "Smit", first_name: "Jill", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 2)
    customer_3 = create(:customer, last_name: "Carpenter", first_name: "Rick", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
    customer_4 = create(:customer, last_name: "Travers", first_name: "Al", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
    customer_5 = create(:customer, last_name: "Beck", first_name: "Dante", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
    customer_6 = create(:customer, last_name: "Bee", first_name: "Lila", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC", id: 6)

    get "/api/v1/customers/find_all?last_name=Carpenter"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(1)
    expect(customers["data"].all? { |hash| hash["attributes"]["last_name"] == "Carpenter" }).to eq(true)
  end

  it "finds all customer record matches based on id" do
    customer_1 = create(:customer, last_name: "Smith", first_name: "Will", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
    customer_2 = create(:customer, last_name: "Smit", first_name: "Jill", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 2)
    customer_3 = create(:customer, last_name: "Carpenter", first_name: "Rick", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
    customer_4 = create(:customer, last_name: "Travers", first_name: "Al", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
    customer_5 = create(:customer, last_name: "Beck", first_name: "Dante", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
    customer_6 = create(:customer, last_name: "Bee", first_name: "Lila", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC", id: 6)

    get "/api/v1/customers/find_all?id=1"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(1)
    expect(customers["data"].all? { |hash| hash["attributes"]["id"] == 1 }).to eq(true)
  end

  it "finds all customer record matches based on created_at" do
    customer_1 = create(:customer, last_name: "Smith", first_name: "Will", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
    customer_2 = create(:customer, last_name: "Smit", first_name: "Jill", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 2)
    customer_3 = create(:customer, last_name: "Carpenter", first_name: "Rick", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
    customer_4 = create(:customer, last_name: "Travers", first_name: "Al", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
    customer_5 = create(:customer, last_name: "Beck", first_name: "Dante", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
    customer_6 = create(:customer, last_name: "Bee", first_name: "Lila", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC", id: 6)

    get "/api/v1/customers/find_all?created_at=2012-03-27 14:53:59 UTC"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(5)
    expect(customers["data"].all? { |hash| Time.parse(hash["attributes"]["created_at"]) == "2012-03-27 14:53:59 UTC" }).to eq(true)
  end

  it "finds all customer record matches based on updated_at" do
    customer_1 = create(:customer, last_name: "Smith", first_name: "Will", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
    customer_2 = create(:customer, last_name: "Smit", first_name: "Jill", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 2)
    customer_3 = create(:customer, last_name: "Carpenter", first_name: "Rick", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
    customer_4 = create(:customer, last_name: "Travers", first_name: "Al", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
    customer_5 = create(:customer, last_name: "Beck", first_name: "Dante", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
    customer_6 = create(:customer, last_name: "Bee", first_name: "Lila", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC", id: 6)

    get "/api/v1/customers/find_all?updated_at=2012-03-27 14:53:59 UTC"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(5)
    expect(customers["data"].all? { |hash| Time.parse(hash["attributes"]["updated_at"]) == "2012-03-27 14:53:59 UTC" }).to eq(true)
  end
end
