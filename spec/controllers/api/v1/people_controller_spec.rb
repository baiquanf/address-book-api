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
     json_response[:people].each do |person_response|
        expect(person_response).to be_present
      end
    end

    it "returns 4 records from the database" do
      expect(json_response[:people].length).to eq(4)
    end

    it { is_expected.to respond_with 200 }

    context "when is not receiving any people_ids parameter" do
      before(:each) do
        get :index
      end

      it "returns 4 records from the database" do
        expect(json_response[:people].length).to eq(4)
      end

      it "returns the people object into each person" do
        json_response[:people].each do |person_response|
          expect(person_response[:first_name]).to be_present
        end
      end

      it_behaves_like "paginated list"

      it { is_expected.to respond_with 200 }
    end
  end

  describe "GET #show" do
    before(:each) do
      @person = FactoryBot.create :person
      get :show, params: { id: @person.id }
    end

    it "has the attributes as a embeded object" do
      expect(json_response[:first_name]).to eql @person.first_name
    end

    it { is_expected.to respond_with 200 }
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        person = FactoryBot.create :person
        @person_attributes = FactoryBot.attributes_for :person
        user = FactoryBot.create :user
        api_authorization_header user.auth_token
        post :create, params: { person_id: person.id, person: @person_attributes }
      end

      it "renders the json representation for the person record just created" do
        expect(json_response[:first_name]).to eql @person_attributes[:first_name]
      end

      it { is_expected.to respond_with 201 }
    end

    context "when is not created" do
      before(:each) do

        person = FactoryBot.create :person
        @invalid_person_attributes = { first_name: "John", name: "Smith", birthday: "2000-01-01" }
        user = FactoryBot.create :user
        api_authorization_header user.auth_token
        post :create, params: { person_id: person.id, person: @invalid_person_attributes }
      end

      it "renders an errors json" do
        expect(json_response).to have_key(:errors)
      end

      it { is_expected.to respond_with 422 }
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
        patch :update, params: { id: @person.id, first_name: "David" }
      end

      it "renders the json representation for the updated user" do
        expect(json_response[:first_name]).to eql "David"
      end

      it { is_expected.to respond_with 200 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @person = FactoryBot.create :person
      user = FactoryBot.create :user
      api_authorization_header user.auth_token
      delete :destroy, params: { id: @person.id }
    end

    it { is_expected.to respond_with 204 }
  end
end