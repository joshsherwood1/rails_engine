class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id,
                        :created_at,
                        :updated_at

  def self.find_by_merchant_id(merchant_id)
    where(merchant_id: merchant_id)
  end

  def self.find_by_name(name)
    where("LOWER(name) = ?", name.downcase)
  end

  def self.find_by_description(description)
    where("LOWER(description) = ?", description.downcase)
  end

  def self.find_by_unit_price(unit_price)
    where(unit_price: unit_price)
  end

  def self.find_by_created_at(created_at)
    where(created_at: created_at)
  end

  def self.find_by_updated_at(updated_at)
    where(updated_at: updated_at)
  end

  def self.find_by_id(id)
    where(id: id)
  end

  def self.get_random_id
    pluck(:id).sample
  end

  def self.items_with_most_revenue(quantity)
    joins(:invoice_items).group(:id).select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").order("revenue desc").limit(quantity)
    # should the following below work????
    #joins(:invoice_items).joins(:transactions).group(:id).merge(Transaction.successful).select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").order("revenue desc").limit(quantity)
  end

  def find_best_day
    binding.pry
    invoices.joins(:invoice_items, :transactions).group("invoices.created_at").merge(Transaction.successful).select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as revenue").order("revenue desc").limit(1)
  end
end
