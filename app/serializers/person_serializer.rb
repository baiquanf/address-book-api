class PersonSerializer
  include FastJsonapi::ObjectSerializer

  has_many :addresses
  
  attributes :first_name, :last_name, :birthday
end
