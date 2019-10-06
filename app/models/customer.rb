class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  validates_presence_of :first_name,
                        :last_name,
                        :created_at,
                        :updated_at

  def self.find_by_first_name(first_name)
    where("LOWER(first_name) = ?", first_name.downcase)
  end

  def self.find_by_last_name(last_name)
    where("LOWER(last_name) = ?", last_name.downcase)
  end

  def self.find_by_id(id)
    where(id: id)
  end

  def self.find_by_updated_at(date)
    where(updated_at: date)
  end

  def self.find_by_created_at(date)
    where(created_at: date)
  end

  def self.get_random_id
    pluck(:id).sample
  end

  def self.find_first_customer_by_first_name(first_name)
    find_by("LOWER(first_name) = ?", first_name.downcase)
  end

  def self.find_first_customer_by_last_name(last_name)
    find_by("LOWER(last_name) = ?", last_name.downcase)
  end
end
