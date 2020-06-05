class Address < ApplicationRecord
  validates :person_id , presence: true
  validates :address_type_id , presence: true
  validates :street, length: { maximum: 50 }
  validates :zip, presence: true, length: { maximum: 20 }
  validates :city , presence: true, length: { maximum: 50 }

  belongs_to :person
  belongs_to :address_type
end
