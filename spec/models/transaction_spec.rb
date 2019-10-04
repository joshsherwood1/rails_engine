require 'rails_helper'

RSpec.describe Transaction, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :credit_card_number }
    it { should validate_presence_of :result }
    it { should validate_presence_of :created_at }
    it { should validate_presence_of :updated_at }
  end

  describe "relationships" do
    it {should belong_to :invoice}
  end

  describe 'class methods' do
    before(:each) do
      customer = create(:customer)
      merchant_5 = create(:merchant, name: "Williamson Group")
      @invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_5.id, id: 1)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: "success", id: 1, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
      @transaction_2 = create(:transaction, invoice_id: @invoice_1.id, result: "success", id: 2, credit_card_number: "4654405418249632", credit_card_expiration_date: "00/0000", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2010-03-27 16:12:25 UTC")
      @transaction_3 = create(:transaction, invoice_id: @invoice_1.id, result: "success", id: 3, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
      @transaction_4 = create(:transaction, invoice_id: @invoice_1.id, result: "failed", id: 4, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
      @transaction_5 = create(:transaction, invoice_id: @invoice_1.id, result: "success", id: 5, credit_card_number: "4654405418249632", credit_card_expiration_date: "", updated_at: "2012-03-28 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
      @transaction_6 = create(:transaction, invoice_id: @invoice_1.id, result: "success", id: 6, credit_card_number: "4654405418249633", credit_card_expiration_date: "", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")

    end


    it 'find_by_invoice_id' do
      expect(Transaction.find_by_invoice_id(@invoice_1.id)).to eq([@transaction_1, @transaction_2, @transaction_3, @transaction_4, @transaction_5 , @transaction_6])
    end

    it 'find_by_id' do
      expect(Transaction.find_by_id(1)).to eq([@transaction_1])
    end

    it 'find_by_created_at' do
      expect(Transaction.find_by_created_at("2012-03-27 16:12:25 UTC")).to eq([@transaction_1, @transaction_3, @transaction_4, @transaction_5 , @transaction_6])
    end

    it 'find_by_updated_at' do
      expect(Transaction.find_by_updated_at("2012-03-27 14:53:59 UTC")).to eq([@transaction_1, @transaction_2, @transaction_3, @transaction_4, @transaction_6])
    end

    it 'find_by_credit_card_number' do
      expect(Transaction.find_by_credit_card_number("4654405418249633")).to eq([@transaction_6])
    end

    it 'find_by_credit_card_expiration_date' do
      expect(Transaction.find_by_credit_card_expiration_date("00/0000")).to eq([@transaction_2])
    end

    it 'find_by_result' do
      expect(Transaction.find_by_result("success")).to eq([@transaction_1, @transaction_2, @transaction_3, @transaction_5, @transaction_6])
    end
  end
end
