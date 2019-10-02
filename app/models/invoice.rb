class Invoice < ApplicationRecord
  has_many :items, through: :invoice_items
  has_many :invoice_items
  has_many :transactions
  belongs_to :customer
  belongs_to :merchant
  validates_presence_of :status,
                        :customer_id,
                        :merchant_id,
                        :created_at,
                        :updated_at
end
