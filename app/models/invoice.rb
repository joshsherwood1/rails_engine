class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer
  belongs_to :merchant
  validates_presence_of :status,
                        :customer_id,
                        :merchant_id,
                        :created_at,
                        :updated_at
  def self.find_by_id(id)
    where(id: id)
  end

  def self.find_by_created_at(created_at)
    where(created_at: created_at)
  end

  def self.find_by_updated_at(updated_at)
    where(updated_at: updated_at)
  end

  def self.find_by_merchant_id(merchant_id)
    where(merchant_id: merchant_id)
  end

  def self.find_by_customer_id(customer_id)
    where(customer_id: customer_id)
  end

  def self.find_by_status(status)
    where("LOWER(status) = ?", status.downcase)
  end

  def self.get_random_id
    pluck(:id).sample
  end

  def self.find_first_invoice_by_status(status)
    find_by("LOWER(status) = ?", status.downcase)
  end
end
