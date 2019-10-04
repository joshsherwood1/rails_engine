class TransactionFindAllSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :invoice_id, :credit_card_number, :result, :created_at, :updated_at, :credit_card_expiration_date
end
