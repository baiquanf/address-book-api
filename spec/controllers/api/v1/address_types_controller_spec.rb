require 'rails_helper'

RSpec.describe Api::V1::AddressTypesController, type: :controller do
  before(:each) do
    user = FactoryBot.create :user
    api_authorization_header user.auth_token
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryBot.create :address_type }
      get :index
    end

    it "returns the people object into each person" do
      json_response[:address_types].each do |address_type|
        expect(address_type).to be_present
      end
    end

    it "returns 4 records from the database" do
      expect(json_response[:address_types].length).to eq(4)
    end

    it { is_expected.to respond_with 200 }

    context "when is not receiving any address_type_ids parameter" do
      before(:each) do
        get :index
      end

      it "returns 4 records from the database" do
        expect(json_response[:address_types].length).to eq(4)
      end

      it "returns the people object into each person" do
        json_response[:address_types].each do |address_type|
          expect(address_type[:name]).to be_present
        end
      end

      it_behaves_like "paginated list"

      it { is_expected.to respond_with 200 }
    end
  end

  describe "GET #show" do
    before(:each) do
      @address_type = FactoryBot.create :address_type
      get :show, params: { id: @address_type.id }
    end

    it "has the attributes as a embeded object" do
      expect(json_response[:name]).to eql @address_type.name
    end

    it { is_expected.to respond_with 200 }
  end
end
