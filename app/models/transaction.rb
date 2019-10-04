class Transaction < ApplicationRecord
  belongs_to :invoice
  validates_presence_of :invoice_id,
                        :credit_card_number,
                        :result,
                        :created_at,
                        :updated_at

  #default_scope { order(id: :asc) }

  scope :successful, -> { where(result: "success") }

  def self.find_by_invoice_id(invoice_id)
    where(invoice_id: invoice_id)
  end

  def self.find_by_credit_card_number(credit_card_number)
    where(credit_card_number: credit_card_number)
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

  def self.find_by_result(result)
    where(result: result)
  end

  def self.find_by_credit_card_expiration_date(credit_card_expiration_date)
    where(credit_card_expiration_date: credit_card_expiration_date)
  end
end
