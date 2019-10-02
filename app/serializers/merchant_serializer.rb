class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  attribute :top_merchants_by_revenue do |object|
  object.items.count
end
end
