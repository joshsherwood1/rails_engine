class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :items
  validates_presence_of :name,
                        :created_at,
                        :updated_at

  def self.merchants_with_most_revenue(quantity)
    joins(:invoice_items).group(:id).select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").order("revenue desc").limit(quantity)
  end
end
