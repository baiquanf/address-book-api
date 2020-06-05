require 'rails_helper'

RSpec.describe Api::V1::AddressesController, type: :controller do
  before(:each) do
    user = FactoryBot.create :user
    api_authorization_header user.auth_token
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryBot.create :address }
      get :index
    end

    it "returns the people object into each person" do
      json_response[:addresses].each do |address|
        expect(address).to be_present
        expect(address[:person_id]).to be_present
        expect(address[:address_type_id]).to be_present
      end
    end

    it "returns 4 records from the database" do
      expect(json_response[:addresses].length).to eq(4)
    end

    it { is_expected.to respond_with 200 }

    context "when is not receiving any address_type_ids parameter" do
      before(:each) do
        get :index
      end

      it "returns 4 records from the database" do
        expect(json_response[:addresses].length).to eq(4)
      end

      it "returns the people object into each person" do
        json_response[:addresses].each do |address|
          expect(address[:street]).to be_present
        end
      end

      it_behaves_like "paginated list"

      it { is_expected.to respond_with 200 }
    end
  end

  describe "GET #show" do
    before(:each) do
      @address = FactoryBot.create :address
      get :show, params: { id: @address.id }
    end

    it "has the attributes as a embeded object" do
      expect(json_response[:street]).to eql @address.street
    end

    it { is_expected.to respond_with 200 }
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        person = FactoryBot.create :person
        address_type = FactoryBot.create :address_type
        post :create, params: { person_id: person.id, address_type_id: address_type.id, street: 'my street', zip: '123456', city: 'Helsinki' }                        
      end

      it "returns the address record" do
        expect(json_response[:id]).to be_present
      end

      it { is_expected.to respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        person = FactoryBot.create :person
        address_type = FactoryBot.create :address_type
        post :create, params: { person_id: person.id, address_type_id: address_type.id, street: 'my street', zip: '', city: 'Helsinki' }
      end

      it "renders an errors json" do
        expect(json_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        expect(json_response[:errors][:zip]).to include "can't be blank"
      end

      it { is_expected.to respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @address = FactoryBot.create :address
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, params: { id: @address.id, street: "your street" }
      end

      it "renders the json representation for the updated user" do
        expect(json_response[:street]).to eql "your street"
      end

      it { is_expected.to respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, params: { id: @address.id, zip: '' }
      end

      it "renders an errors json" do
        expect(json_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        expect(json_response[:errors][:zip]).to include "can't be blank"
      end

      it { is_expected.to respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @address = FactoryBot.create :address
      delete :destroy, params: { id: @address.id }
    end

    it { is_expected.to respond_with 204 }
  end
end
