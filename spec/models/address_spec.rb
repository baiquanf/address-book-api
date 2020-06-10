require 'rails_helper'

RSpec.describe Address, type: :model do
  before { build(:address) }

  context "presence" do
    it { is_expected.to validate_presence_of :person_id }
    it { is_expected.to validate_length_of(:address_type_id ) }
    it { is_expected.to validate_presence_of :zip }
    it { is_expected.to validate_length_of(:zip).is_at_most(20) }
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_length_of(:city).is_at_most(50) }
    it { is_expected.to validate_length_of(:street).is_at_most(50) }
  end

  context "associations" do
    it { is_expected.to  belong_to(:person) }
    it { is_expected.to  belong_to(:address_type) }
  end
end
