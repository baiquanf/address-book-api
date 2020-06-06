class AddressSerializer
  include FastJsonapi::ObjectSerializer

  attributes :person_id, :address_type_id, :street, :zip, :city
end
