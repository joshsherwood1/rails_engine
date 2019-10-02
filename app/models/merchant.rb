class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  validates_presence_of :name,
                        :created_at,
                        :updated_at
end
