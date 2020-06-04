require 'rails_helper'

RSpec.describe 'address_types routes', :type => :routing do
  it 'should route to address_types index' do
    RSpec.describe 'address_types routes', :type => :routing do
      it { is_expected.to route(:get, '/api/v1/address_types').to('api/v1/address_types#index', format: :json) }
      it { is_expected.to route(:get, '/api/v1/address_types/1').to('api/v1/address_types#show', id: '1', format: :json) }
    end
  end
end
