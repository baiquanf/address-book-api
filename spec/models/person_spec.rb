require 'rails_helper'

RSpec.describe Person, type: :model do
  context "valid Factory" do
    it "has a valid factory" do
      expect(create(:person_with_addresses)).to be_valid
    end
  end

  context "validations" do
    before { build(:person) }

    context "presence" do
      it { is_expected.to validate_presence_of :first_name }
      it { is_expected.to validate_length_of(:first_name).is_at_most(50) }
      it { is_expected.to validate_presence_of :last_name }
      it { is_expected.to validate_length_of(:last_name).is_at_most(50) }
      it { is_expected.not_to validate_presence_of(:birthday) }
    end
  end

  context "associations" do
    it { is_expected.to  have_many(:addresses) }
  end
end
