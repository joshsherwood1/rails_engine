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

  it "finds single transaction record based on id" do
    customer = create(:customer)
    merchant_5 = create(:merchant, name: "Williamson Group")
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_5.id, id: 1)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 1)
    transaction_2 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 2)
    transaction_3 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 3)
    transaction_4 = create(:transaction, invoice_id: invoice_1.id, result: "failed", id: 4)
    transaction_5 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 5)
    transaction_6 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 6)

    get "/api/v1/transactions/find?id=3"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"]).to eq(transaction_3.id.to_s)
  end

  it "finds single transaction record based on invoice id" do
    customer = create(:customer)
    merchant_5 = create(:merchant, name: "Williamson Group")
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_5.id, id: 1)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 1)
    transaction_2 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 2)
    transaction_3 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 3)
    transaction_4 = create(:transaction, invoice_id: invoice_1.id, result: "failed", id: 4)
    transaction_5 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 5)
    transaction_6 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 6)

    get "/api/v1/transactions/find?invoice_id=1"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"]).to eq(transaction_1.id.to_s)
  end

  it "finds single transaction record based on result" do
    customer = create(:customer)
    merchant_5 = create(:merchant, name: "Williamson Group")
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_5.id, id: 1)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 1)
    transaction_2 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 2)
    transaction_3 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 3)
    transaction_4 = create(:transaction, invoice_id: invoice_1.id, result: "failed", id: 4)
    transaction_5 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 5)
    transaction_6 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 6)

    get "/api/v1/transactions/find?result=failed"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"]).to eq(transaction_4.id.to_s)
  end

  it "finds single transaction record based on credit card number" do
    customer = create(:customer)
    merchant_5 = create(:merchant, name: "Williamson Group")
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_5.id, id: 1)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 1, credit_card_number: "4654405418249632")
    transaction_2 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 2, credit_card_number: "4654405418249632")
    transaction_3 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 3, credit_card_number: "4654405418249632")
    transaction_4 = create(:transaction, invoice_id: invoice_1.id, result: "failed", id: 4, credit_card_number: "4654405418249632")
    transaction_5 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 5, credit_card_number: "4654405418249632")
    transaction_6 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 6, credit_card_number: "4654405418249633")

    get "/api/v1/transactions/find?credit_card_number=4654405418249633"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"]).to eq(transaction_6.id.to_s)
  end

  it "finds single transaction record based on credit card expiration date" do
    customer = create(:customer)
    merchant_5 = create(:merchant, name: "Williamson Group")
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_5.id, id: 1)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 1, credit_card_number: "4654405418249632", credit_card_expiration_date: "")
    transaction_2 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 2, credit_card_number: "4654405418249632", credit_card_expiration_date: "00/0000")
    transaction_3 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 3, credit_card_number: "4654405418249632", credit_card_expiration_date: "")
    transaction_4 = create(:transaction, invoice_id: invoice_1.id, result: "failed", id: 4, credit_card_number: "4654405418249632", credit_card_expiration_date: "")
    transaction_5 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 5, credit_card_number: "4654405418249632", credit_card_expiration_date: "")
    transaction_6 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 6, credit_card_number: "4654405418249633", credit_card_expiration_date: "")

    get "/api/v1/transactions/find?credit_card_expiration_date=00/0000"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"]).to eq(transaction_2.id.to_s)
  end

  it "finds single transaction record based on created_at" do
    customer = create(:customer)
    merchant_5 = create(:merchant, name: "Williamson Group")
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_5.id, id: 1)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 1, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    transaction_2 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 2, credit_card_number: "4654405418249632", credit_card_expiration_date: "00/0000", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2010-03-27 16:12:25 UTC")
    transaction_3 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 3, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    transaction_4 = create(:transaction, invoice_id: invoice_1.id, result: "failed", id: 4, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    transaction_5 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 5, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    transaction_6 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 6, credit_card_number: "4654405418249633", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    get "/api/v1/transactions/find?created_at=2010-03-27 16:12:25 UTC"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"]).to eq(transaction_2.id.to_s)
  end

  it "finds single transaction record based on updated_at" do
    customer = create(:customer)
    merchant_5 = create(:merchant, name: "Williamson Group")
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_5.id, id: 1)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 1, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    transaction_2 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 2, credit_card_number: "4654405418249632", credit_card_expiration_date: "00/0000", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2010-03-27 16:12:25 UTC")
    transaction_3 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 3, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    transaction_4 = create(:transaction, invoice_id: invoice_1.id, result: "failed", id: 4, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    transaction_5 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 5, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-28 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    transaction_6 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 6, credit_card_number: "4654405418249633", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    get "/api/v1/transactions/find?updated_at=2012-03-28 14:53:59 UTC"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"]).to eq(transaction_5.id.to_s)
  end

  it "finds all transaction record matches based on id" do
    customer = create(:customer)
    merchant_5 = create(:merchant, name: "Williamson Group")
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_5.id, id: 1)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 1, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    transaction_2 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 2, credit_card_number: "4654405418249632", credit_card_expiration_date: "00/0000", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2010-03-27 16:12:25 UTC")
    transaction_3 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 3, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    transaction_4 = create(:transaction, invoice_id: invoice_1.id, result: "failed", id: 4, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    transaction_5 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 5, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-28 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    transaction_6 = create(:transaction, invoice_id: invoice_1.id, result: "success", id: 6, credit_card_number: "4654405418249633", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    get "/api/v1/transactions/find_all?id=2"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(1)
    expect(transactions["data"].all? { |hash| hash["attributes"]["id"] == 2 }).to eq(true)
  end
end
