require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "GET #show" do
    before(:each) do
      @user = FactoryBot.create :user
      get :show, params: { id: @user.id }
    end

    it "returns the information about a reporter on a hash" do
      expect(json_response[:email]).to eql @user.email
    end

    it { is_expected.to respond_with :ok }
  end

  context "when is successfully created" do
    before(:each) do
      @user_attributes = FactoryBot.attributes_for :user

      post :create, params:
        { "data": { 
          "attributes": {
            "email": @user_attributes[:email],
            "password": @user_attributes[:password],
            "password_confirmation": @user_attributes[:password_confirmation]
        }}}
    end

    it "renders the json representation for the user record just created" do
      expect(json_response[:email]).to eql @user_attributes[:email]
    end

    it { is_expected.to respond_with :created }
  end

  context "when is not created" do
    before(:each) do
      #no email
      @invalid_user_attributes = { password: "password",
                                   password_confirmation: "password" }
      post :create, params: 
        { "data": { 
          "attributes": {
            "email": @invalid_user_attributes[:email],
            "password": @invalid_user_attributes[:password],
            "password_confirmation": @invalid_user_attributes[:password_confirmation]
        }}}

    end

    it "renders an errors json" do
      expect(json_response).to have_key(:errors)
    end

    it "renders the json errors on why the user could not be created" do
      expect(json_response[:errors][:email]).to include "can't be blank"
    end

    it { is_expected.to respond_with :unprocessable_entity }
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryBot.create :user
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        @user = FactoryBot.create(:user)
        patch :update, params: 
        { "data": { 
          "attributes": {
            "email": "newuser@example.com" 
        }}}.merge(id: @user.id)
      end

      it "renders the json representation for the updated user" do
        expect(json_response[:email]).to eql "newuser@example.com"
      end

      it { is_expected.to respond_with :ok }
    end

    context "when is not created" do
      before(:each) do
        @user = FactoryBot.create :user
        patch :update, params:
        { "data": { 
          "attributes": {
            "email": "bademail.com" 
        }}}.merge(id: @user.id)
      end

      it "renders an errors json" do
        expect(json_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end

      it { is_expected.to respond_with :unprocessable_entity }
    end
  end

	describe "DELETE #destroy" do
	  before(:each) do
	    @user = FactoryBot.create :user
      api_authorization_header @user.auth_token
	    delete :destroy, params: { id: @user.id }
	  end

	  it { is_expected.to respond_with :no_content }
	end

end
