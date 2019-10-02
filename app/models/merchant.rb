class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  validates_presence_of :name,
                        :created_at,
                        :updated_at

  def self.merchants_with_most_revenue(quantity)
    joins(:invoices).joins(:invoice_items).group(:id).select("merchants.*, sum()").limit(quantity)
  end
end
