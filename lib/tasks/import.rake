require 'csv'

namespace :import do
  desc "Import prospects from CSV file"
  task all: :environment do

    CSV.foreach('./lib/sales_engine/data/transactions.csv', headers: true) do |row|
      Transaction.create(row.to_h)
    end

    CSV.foreach('./lib/sales_engine/data/items.csv', headers: true) do |row|
      Item.create(row.to_h)
    end

    CSV.foreach('./lib/sales_engine/data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end

    CSV.foreach('./lib/sales_engine/data/customers.csv', headers: true) do |row|
      Customer.create(row.to_h)
    end

    CSV.foreach('./lib/sales_engine/data/invoices.csv', headers: true) do |row|
      Invoice.create(row.to_h)
    end

    CSV.foreach('./lib/sales_engine/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create(row.to_h)
    end
  end

  desc "Import transactions from CSV file"
  task transaction: :environment do

    CSV.foreach('./lib/sales_engine/data/transactions.csv', headers: true) do |row|
      Transaction.create(row.to_h)
    end
  end
end
