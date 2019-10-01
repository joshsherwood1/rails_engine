require 'csv'

namespace :import do
  desc "Import prospects from CSV file"
  task all: :environment do
    CSV.foreach('./lib/sales_engine/data/items.csv', headers: true) do |row|
      Item.create(row.to_h)
    end

    CSV.foreach('./lib/sales_engine/data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end

    CSV.foreach('./lib/sales_engine/data/customers.csv', headers: true) do |row|
      Customer.create(row.to_h)
    end
  end

end
