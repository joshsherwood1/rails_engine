FactoryBot.define do
  factory :transaction do
    invoice_id { 1 }
    credit_card_number { 4654405418249632 }
    credit_card_expiration_date {  }
    result { "success" }
    created_at { "2012-03-27 14:54:09 UTC" }
    updated_at { "2012-03-27 14:54:09 UTC" }
  end
end
