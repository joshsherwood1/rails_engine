FactoryBot.define do
  factory :invoice_item do
    item_id { 539 }
    invoice_id { 1 }
    quantity { 5 }
    unit_price { 13635 }
    created_at { "2012-03-27 14:54:09 UTC" }
    updated_at { "2012-03-27 14:54:09 UTC" }
  end
end
