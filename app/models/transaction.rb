class Transaction < ApplicationRecord
  belongs_to :invoice
  validates_presence_of :invoice_id,
                        :credit_card_number,
                        :result,
                        :created_at,
                        :updated_at

  #default_scope { order(id: :asc) }

  scope :successful, -> { where(result: "success") }
end
