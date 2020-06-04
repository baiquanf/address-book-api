require 'rails_helper'

RSpec.describe AddressType, type: :model do
  context "valid Factory" do
    it "has a valid factory" do
      expect(FactoryBot.build(:address_type)).to be_valid
    end
  end
  
  context "validations" do
    before { FactoryBot.build(:address_type) }

    context "presence" do
      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_length_of(:name).is_at_most(50) }
    end
  end

  context "associations" do
    it { is_expected.to  have_many(:addresses) }
  end
end
