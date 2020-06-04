require 'rails_helper'

RSpec.describe 'addresses routes', :type => :routing do
  context 'through /api/v1/addresses' do
    it { is_expected.to route(:get, '/api/v1/addresses').to('api/v1/addresses#index', format: :json) }
    it { is_expected.to route(:get, '/api/v1/addresses/1').to('api/v1/addresses#show', id: '1', format: :json) }
    it { is_expected.not_to route(:post, '/api/v1/addresses').to('api/v1/addresses#create', format: :json) }
    it { is_expected.not_to route(:put, '/api/v1/addresses/1').to('api/v1/addresses#update', id: '1', format: :json) }
    it { is_expected.not_to route(:patch, '/api/v1/addresses/1').to('api/v1/addresses#update', id: '1', format: :json) }
    it { is_expected.not_to route(:delete, '/api/v1/addresses/1').to('api/v1/addresses#destroy', id: '1', format: :json) }
  end

  context 'through /api/v1/people/:id/addresses' do
    it { is_expected.to route(:get, '/api/v1/people/1/addresses').to('api/v1/addresses#index', :person_id => "1", format: :json) }
    it { is_expected.to route(:get, '/api/v1/people/1/addresses/1').to('api/v1/addresses#show', :person_id => "1", id: '1', format: :json) }
    it { is_expected.to route(:post, '/api/v1/people/1/addresses').to('api/v1/addresses#create', :person_id => "1", format: :json) }
    it { is_expected.to route(:put, '/api/v1/people/1/addresses/1').to('api/v1/addresses#update', :person_id => "1", id: '1', format: :json) }
    it { is_expected.to route(:patch, '/api/v1/people/1/addresses/1').to('api/v1/addresses#update', :person_id => "1", id: '1', format: :json) }
    it { is_expected.to route(:delete, '/api/v1/people/1/addresses/1').to('api/v1/addresses#destroy', :person_id => "1", id: '1', format: :json) }
  end
end
