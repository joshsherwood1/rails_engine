class ItemFindAllSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  attribute :unit_price do |object|
   (object.unit_price / 100).round(2).to_s
  end
end
