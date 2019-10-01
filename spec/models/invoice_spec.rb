require 'rails_helper'

RSpec.describe Invoice, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  describe "validations" do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :status }
    it { should validate_presence_of :created_at }
    it { should validate_presence_of :updated_at }
  end
end
