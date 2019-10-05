require 'rails_helper'

RSpec.describe Customer, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  describe "validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :created_at }
    it { should validate_presence_of :updated_at }
  end

  describe "relationships" do
    it {should have_many :invoices}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'class methods' do
    before(:each) do
      @customer_1 = create(:customer, last_name: "Smith", first_name: "Will", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
      @customer_2 = create(:customer, last_name: "Smit", first_name: "Jill", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 2)
      @customer_3 = create(:customer, last_name: "Carpenter", first_name: "Rick", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
      @customer_4 = create(:customer, last_name: "Travers", first_name: "Al", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
      @customer_5 = create(:customer, last_name: "Beck", first_name: "Dante", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
      @customer_6 = create(:customer, last_name: "Bee", first_name: "Lila", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC", id: 6)
      @merchant_1 = create(:merchant, name: "Schroeder-Jerde", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
      @merchant_2 = create(:merchant, name: "Klein, Rempel and Jones", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-28 14:53:59 UTC", id: 2)
      @merchant_3 = create(:merchant, name: "Willms and Sons", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
      @merchant_4 = create(:merchant, name: "Cummings-Thiel", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
      @merchant_5 = create(:merchant, name: "Williamson Group", updated_at: "2012-02-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
      @merchant_6 = create(:merchant, name: "Williamson Group", updated_at: "2012-02-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 6)
      invoice_1 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_1.id)
      invoice_2 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_2.id)
      invoice_3 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_3.id)
      invoice_4 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_4.id)
      invoice_5 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_4.id)
      invoice_6 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_5.id)
      item_1 = create(:item, unit_price: 12345, merchant_id: @merchant_5.id)
      item_2 = create(:item, unit_price: 22345, merchant_id: @merchant_1.id)
      item_3 = create(:item, unit_price: 32345, merchant_id: @merchant_2.id)
      item_4 = create(:item, unit_price: 42345, merchant_id: @merchant_3.id)
      item_5 = create(:item, unit_price: 52345, merchant_id: @merchant_4.id)
      item_6 = create(:item, unit_price: 62345, merchant_id: @merchant_4.id)
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
    end


    it 'find_by_first_name' do
      expect(Customer.find_by_first_name("Rick")).to eq([@customer_3])
    end

    it 'find_by_last_name' do
      expect(Customer.find_by_last_name("Carpenter")).to eq([@customer_3])
    end

    it 'find_by_id' do
      expect(Customer.find_by_id(6)).to eq([@customer_6])
    end

    it 'find_by_created_at' do
      expect(Customer.find_by_created_at("2012-03-27 14:53:59 UTC")).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
    end

    it 'find_by_updated_at' do
      expect(Customer.find_by_updated_at("2012-03-27 14:53:59 UTC")).to eq([@customer_1, @customer_2, @customer_4, @customer_5, @customer_6])
    end
  end
end
