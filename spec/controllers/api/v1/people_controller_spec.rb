require 'rails_helper'

RSpec.describe Api::V1::PeopleController, type: :controller do
  before(:each) do
    user = FactoryBot.create :user
    api_authorization_header user.auth_token
  end
  
  describe "GET #index" do
    before(:each) do
      4.times { FactoryBot.create :person }
      get :index
    end

    it "returns the people object into each person" do
      json_response[:data].each do |person|
        expect(person).to be_present
      end
    end

    it "returns 4 records from the database" do
      expect(json_response[:data].size).to eq(4)
    end

    it { is_expected.to respond_with :ok }

    context "when is not receiving any people_ids parameter" do
      before(:each) do
        get :index
      end

      it "returns 4 records from the database" do
        expect(json_response[:data].size).to eq(4)
      end

      it "returns the people object into each person" do
        json_response[:data].each do |person|
          person[:attributes].tap do |attributes|
            expect(attributes[:first_name]).to be_present
            expect(attributes[:last_name]).to be_present
            expect(attributes[:birthday]).to be_present
          end
        end
      end

      it_behaves_like "paginated list"

      it { is_expected.to respond_with :ok }
    end
  end

  describe "GET #show" do
    before(:each) do
      @person = FactoryBot.create :person
      get :show, params: { id: @person.id }
    end

    it "has the attributes as a embeded object" do
      json_response[:data][:attributes].tap do |person|
        expect(person[:first_name]).to eql @person.first_name
        expect(person[:last_name]).to eql @person.last_name
        expect(person[:birthday].to_date).to eql @person.birthday
      end
    end

    it { is_expected.to respond_with :ok }
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        person = FactoryBot.create :person
        @person_attributes = FactoryBot.attributes_for :person
        user = FactoryBot.create :user
        api_authorization_header user.auth_token
        post :create, params:
          { "data": { 
            "attributes": {
              "person_id": person.id,
              "first_name": @person_attributes[:first_name],
              "last_name": @person_attributes[:last_name],
              "birthday": @person_attributes[:birthday]
          }}}

        { person_id: person.id, person: @person_attributes }
      end

      it "renders the json representation for the person record just created" do
        json_response[:data][:attributes].tap do |attributes|
          expect(attributes[:first_name]).to eql @person_attributes[:first_name]
          expect(attributes[:last_name]).to eql @person_attributes[:last_name]
          expect(attributes[:birthday].to_date).to eql @person_attributes[:birthday]
        end
      end

      it { is_expected.to respond_with :created }
    end

    context "when is not created" do
      before(:each) do

        person = FactoryBot.create :person
        @invalid_person_attributes = { first_name: "John", name: "Smith", birthday: "2000-01-01" }
        user = FactoryBot.create :user
        api_authorization_header user.auth_token
        post :create, params:
          { "data": { 
            "attributes": {
              "person_id": person.id,
              "first_name": @invalid_person_attributes[:first_name],
              "last_name": @invalid_person_attributes[:last_name],
              "birthday": @invalid_person_attributes[:birthday]
          }}}
      end

      it "renders an errors json" do
        expect(json_response).to have_key(:errors)
      end

      it { is_expected.to respond_with :unprocessable_entity }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @person = FactoryBot.create :person
      user = FactoryBot.create :user
      api_authorization_header user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, params:
          { "data": { 
            "attributes": {
              "first_name": "David"
          }}}.merge(id: @person.id)
      end

      it "renders the json representation for the updated user" do
        expect(json_response[:data][:attributes][:first_name]).to eql "David"
      end

      it { is_expected.to respond_with :ok }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @person = FactoryBot.create :person
      user = FactoryBot.create :user
      api_authorization_header user.auth_token
      delete :destroy, params: { id: @person.id }
    end

    it { is_expected.to respond_with :no_content }
  end
end