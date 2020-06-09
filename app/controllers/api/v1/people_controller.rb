class Api::V1::PeopleController < ApplicationController
  include Pagination

  before_action :authenticate_with_token!
  respond_to :json

  def index
    people = Person.search(params).page(current_page).per(params[:per_page])

    options = {
      links: {
        first: api_v1_people_path(per_page: per_page),
        self: api_v1_people_path(page: current_page, per_page: per_page),
        last: api_v1_people_path(page: people.total_pages,per_page: per_page)
      },
      meta: pagination(people, per_page)
    }

    render json: PersonSerializer.new(people, options).serializable_hash
  end

  def show
    person = Person.find(params[:id])
    respond_with PersonSerializer.new(person).serializable_hash
  end

  def create
    person = Person.new(person_params) 
    if person.save
      render json: PersonSerializer.new(person).serializable_hash, status: :created, location: [:api, :v1, person] 
    else
      render json: { errors: person.errors }, status: :unprocessable_entity
    end
  end

  def update
    person = Person.find(params[:id])
    if person.update(person_params)
      render json: PersonSerializer.new(person).serializable_hash, status: :ok, location: [:api, :v1, person]
    else
      render json: { errors: person.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    person = Person.find(params[:id])
    person.destroy
    head :no_content
  end

  private

    def person_params
      params.require(:data).require(:attributes).
        permit(:first_name, :last_name, :birthday) ||
      ActionController::Parameters.new
    end
end
