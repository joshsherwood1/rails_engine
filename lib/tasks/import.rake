namespace :import do
  desc "Import prospects from CSV file"
  task item: :environment do
    CSV.foreach('../3000-prospects.csv', headers: true) do |row|
    Prospect.create(row.to_h)
  end
  end

end
