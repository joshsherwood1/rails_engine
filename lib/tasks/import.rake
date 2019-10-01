require 'csv'

namespace :import do
  desc "Import prospects from CSV file"
  task item: :environment do
    CSV.foreach('./lib/sales_engine/data/items.csv', headers: true) do |row|
      Item.create(row.to_h)
    end

    CSV.foreach('./lib/sales_engine/data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end
  end

end
