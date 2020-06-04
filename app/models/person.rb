class Person < ApplicationRecord
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  has_many :addresses, dependent: :destroy

  def self.search(params = {})
    people = params[:people_ids].present? ? Person.where(id: params[:people_ids]) : Person.all

    people = people.filter_by_last_name(params[:keyword]) if params[:keyword]
    people = people.order_by_last_name if params[:order_by_name].present?

    people
  end
end
