class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id,
                        :merchant_id,
                        :created_at,
                        :updated_at
end
