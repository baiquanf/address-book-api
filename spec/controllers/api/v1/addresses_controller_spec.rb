require 'rails_helper'

RSpec.describe Api::V1::AddressesController, type: :controller do
  before(:each) do
    user = create :user
    api_authorization_header user.auth_token
  end

  describe "GET #index" do
    before(:each) do
      4.times { create :address }
      get :index
    end

    it "returns the people object into each person" do
      json_response[:data].each do |address|
        address[:attributes].tap do |attributes|
          expect(attributes[:person_id]).to be_present
          expect(attributes[:address_type_id]).to be_present
          expect(attributes[:street]).to be_present
          expect(attributes[:zip]).to be_present
          expect(attributes[:city]).to be_present
        end
      end
    end

    it "returns 4 records from the database" do
      expect(json_response[:data].size).to eq(4)
    end

    it { is_expected.to respond_with :ok }

    context "when is not receiving any address_type_ids parameter" do
      before(:each) do
        get :index
      end

      it "returns 4 records from the database" do
        expect(json_response[:data].size).to eq(4)
      end

      it "returns the addresses object into each address" do
        json_response[:data].each do |address|
          address[:attributes].tap do |attributes|
            expect(attributes[:person_id]).to be_present
            expect(attributes[:address_type_id]).to be_present
            expect(attributes[:street]).to be_present
            expect(attributes[:zip]).to be_present
            expect(attributes[:city]).to be_present
          end
        end
      end

      it_behaves_like "paginated list"

      it { is_expected.to respond_with :ok }
    end
  end

  describe "GET #show" do
    before(:each) do
      @address = create :address
      get :show, params: { id: @address.id }
    end

    it "has the attributes as a embeded object" do
      expect(json_response[:data][:attributes][:street]).to eql @address.street
    end

    it { is_expected.to respond_with :ok }
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        person = create :person
        address_type = create :address_type
        post :create, params:
          { "data": { 
            "attributes": {
              "person_id": person.id,
              "address_type_id": address_type.id,
              "street": 'my street',
              "zip": '123456',
              "city": 'Helsinki'
          }}}                       
      end

      it "returns the address record" do
        json_response[:data][:attributes].tap do |address|
          expect(address[:person_id]).to be_present
          expect(address[:address_type_id]).to be_present
          expect(address[:street]).to be_present
          expect(address[:zip]).to be_present
          expect(address[:city]).to be_present
        end
      end

      it { is_expected.to respond_with :created }
    end

    context "when is not created" do
      before(:each) do
        person = create :person
        address_type = create :address_type
        post :create, params:
          { "data": { 
            "attributes": {
              "person_id": person.id,
              "address_type_id": address_type.id,
              "street": 'my street',
              "zip": '',
              "city": 'Helsinki'
          }}}
      end

      it "renders an errors json" do
        expect(json_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        expect(json_response[:errors][:zip]).to include "can't be blank"
      end

      it { is_expected.to respond_with :unprocessable_entity }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @address = create :address
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, params:
          { "data": { 
            "attributes": {
              "street": 'your street'
          }}}.merge(id: @address.id)
      end

      it "renders the json representation for the updated user" do
        expect(json_response[:data][:attributes][:street]).to eql "your street"
      end

      it { is_expected.to respond_with :ok }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, params:
          { "data": { 
            "attributes": {
              "zip": ''
          }}}.merge(id: @address.id)
      end

      it "renders an errors json" do
        expect(json_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        expect(json_response[:errors][:zip]).to include "can't be blank"
      end

      it { is_expected.to respond_with :unprocessable_entity }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @address = create :address
      delete :destroy, params: { id: @address.id }
    end

    it { is_expected.to respond_with :no_content }
  end
end
