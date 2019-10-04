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

  def self.find_by_name(name)
    where(name: name)
  end

  def self.find_by_id(id)
    where(id: id)
  end

  def self.find_by_updated_at(date)
    where(updated_at: date)
  end

  def self.find_by_created_at(date)
    where(created_at: date)
  end
end
