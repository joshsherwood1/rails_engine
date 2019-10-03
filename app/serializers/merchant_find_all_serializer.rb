class MerchantFindAllSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :updated_at, :created_at
end
