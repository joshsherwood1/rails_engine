require 'rails_helper'

RSpec.describe Invoice, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  describe "validations" do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :status }
    it { should validate_presence_of :created_at }
    it { should validate_presence_of :updated_at }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should belong_to :customer}
    it {should have_many :transactions}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe 'class methods' do
    before(:each) do
      @customer_1 = create(:customer)
      @merchant_1 = create(:merchant, name: "Schroeder-Jerde", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 1)
      @merchant_2 = create(:merchant, name: "Klein, Rempel and Jones", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-28 14:53:59 UTC", id: 2)
      @merchant_3 = create(:merchant, name: "Willms and Sons", updated_at: "2012-03-27 14:54:00 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 3)
      @merchant_4 = create(:merchant, name: "Cummings-Thiel", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 4)
      @merchant_5 = create(:merchant, name: "Williamson Group", updated_at: "2012-02-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 5)
      @merchant_6 = create(:merchant, name: "Williamson Group", updated_at: "2012-02-27 14:53:59 UTC", created_at: "2012-03-27 14:53:59 UTC", id: 6)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_1.id, id: 1, status: "shipped", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
      @invoice_2 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_2.id, id: 2, status: "shipped", updated_at: "2012-03-27 14:53:58 UTC", created_at: "2012-03-27 16:12:25 UTC")
      @invoice_3 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_3.id, id: 3, status: "shipped", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
      @invoice_4 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_4.id, id: 4, status: "shipped", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
      @invoice_5 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_4.id, id: 5, status: "not shipped", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-29 16:12:25 UTC")
      @invoice_6 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_5.id, id: 6, status: "shipped", updated_at: "2012-03-27 14:53:59 UTC", created_at: "2012-03-27 16:12:25 UTC")
    end


    it 'find_by_status' do
      expect(Invoice.find_by_status("shipped")).to eq([@invoice_1, @invoice_2, @invoice_3, @invoice_4, @invoice_6])
    end

    it 'find_by_id' do
      expect(Invoice.find_by_id(2)).to eq([@invoice_2])
    end

    it 'find_by_created_at' do
      expect(Invoice.find_by_created_at("2012-03-27 16:12:25 UTC")).to eq([@invoice_1, @invoice_2, @invoice_3, @invoice_4, @invoice_6])
    end

    it 'find_by_updated_at' do
      expect(Invoice.find_by_updated_at("2012-03-27 14:53:59 UTC")).to eq([@invoice_1, @invoice_3, @invoice_4, @invoice_5, @invoice_6])
    end

    it 'find_by_customer_id' do
      expect(Invoice.find_by_customer_id(@customer_1.id)).to eq([@invoice_1, @invoice_2, @invoice_3, @invoice_4, @invoice_5, @invoice_6])
    end

    it 'find_by_merchant_id' do
      expect(Invoice.find_by_merchant_id(4)).to eq([@invoice_4, @invoice_5])
    end

  end
end
