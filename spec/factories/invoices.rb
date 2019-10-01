FactoryBot.define do
  factory :invoice do
    customer_id { 1 }
    merchant_id { 26 }
    status { "shipped" }
    created_at { "2012-03-25 09:54:09 UTC" }
    updated_at { "2012-03-25 09:54:09 UTC" }
  end
end
