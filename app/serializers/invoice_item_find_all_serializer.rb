class InvoiceItemFindAllSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  attribute :unit_price do |object|
   (object.unit_price / 100).round(2).to_s
  end
end
