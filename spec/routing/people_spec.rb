require 'rails_helper'

RSpec.describe 'people routes', :type => :routing do
  it { is_expected.to route(:get, '/api/v1/people').to('api/v1/people#index', format: :json) }
  it { is_expected.to route(:get, '/api/v1/people/1').to('api/v1/people#show', id: '1', format: :json) }
  it { is_expected.to route(:post, '/api/v1/people').to('api/v1/people#create', format: :json) }
  it { is_expected.to route(:put, '/api/v1/people/1').to('api/v1/people#update', id: '1', format: :json) }
  it { is_expected.to route(:patch, '/api/v1/people/1').to('api/v1/people#update', id: '1', format: :json) }
  it { is_expected.to route(:delete, '/api/v1/people/1').to('api/v1/people#destroy', id: '1', format: :json) }
end

