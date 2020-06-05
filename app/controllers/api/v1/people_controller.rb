class Api::V1::PeopleController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
    people = Person.search(params).page(params[:page]).per(params[:per_page])
    render json: people, meta: pagination(people, params[:per_page])
  end

  def show
    respond_with Person.find(params[:id])
  end

  def create
    person = Person.new(person_params) 
    if person.save
      render json: person, status: 201, location: [:api, :v1, person] 
    else
      render json: { errors: person.errors }, status: 422
    end
  end

  def update
    person = Person.find(params[:id])
    if person.update(person_params)
      render json: person, status: 200, location: [:api, :v1, person]
    else
      render json: { errors: person.errors }, status: 422
    end
  end

  def destroy
    person = Person.find(params[:id])
    person.destroy
    head 204
  end

  private

    def person_params
      params.require(:person).permit(:first_name, :last_name, :birthday)
    end
end
