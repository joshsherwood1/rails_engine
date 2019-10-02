class Item < ApplicationRecord
  has_many :invoices, through: :invoice_items
  has_many :invoice_items
  belongs_to :merchant
  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id,
                        :created_at,
                        :updated_at
end
