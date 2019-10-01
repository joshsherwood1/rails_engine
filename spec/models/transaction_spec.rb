require 'rails_helper'

RSpec.describe Transaction, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :credit_card_number }
    it { should validate_presence_of :credit_card_expiration_date }
    it { should validate_presence_of :result }
    it { should validate_presence_of :created_at }
    it { should validate_presence_of :updated_at }
  end
end