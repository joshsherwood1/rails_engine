class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  validates_presence_of :item_id,
                        :invoice_id,
                        :quantity,
                        :unit_price,
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

  def self.find_by_invoice_id(invoice_id)
    where(invoice_id: invoice_id)
  end

  def self.find_by_item_id(item_id)
    where(item_id: item_id)
  end

  def self.find_by_unit_price(unit_price)
    where(unit_price: unit_price)
  end

  def self.find_by_quantity(quantity)
    where(quantity: quantity)
  end

  def self.get_random_id
    pluck(:id).sample
  end
end
