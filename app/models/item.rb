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
    where(name: name)
  end

  def self.find_by_description(description)
    where(description: description)
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
end
