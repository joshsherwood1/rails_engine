class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  validates_presence_of :name,
                        :created_at,
                        :updated_at

  def self.merchants_with_most_revenue(quantity)
    joins(:invoice_items).group(:id).select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").order("revenue desc").limit(quantity)
    # should the following below work????
    #joins(:invoice_items).joins(:transactions).group(:id).merge(Transaction.successful).select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").order("revenue desc").limit(quantity)
  end
end
