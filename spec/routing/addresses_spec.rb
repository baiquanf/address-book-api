require 'rails_helper'

RSpec.describe 'addresses routes', :type => :routing do
  it { is_expected.to route(:get, '/api/v1/addresses').to('api/v1/addresses#index', format: :json) }
  it { is_expected.to route(:get, '/api/v1/addresses/1').to('api/v1/addresses#show', id: '1', format: :json) }
  it { is_expected.to route(:post, '/api/v1/addresses').to('api/v1/addresses#create', format: :json) }
  it { is_expected.to route(:put, '/api/v1/addresses/1').to('api/v1/addresses#update', id: '1', format: :json) }
  it { is_expected.to route(:patch, '/api/v1/addresses/1').to('api/v1/addresses#update', id: '1', format: :json) }
  it { is_expected.to route(:delete, '/api/v1/addresses/1').to('api/v1/addresses#destroy', id: '1', format: :json) }
end
