require 'spec_helper'

describe JobsController do

  describe 'POST jobs' do
    let(:urls) { ['https://www.statuspage.io'] }


    it 'returns http status 202' do
      post 'create'
      expect(response.status).to eq 202
    end

    it 'returns json content type' do
      post 'create'
      expect(response.content_type).to eq "application/json"
    end

    it 'returns the id of the created job' do
      post 'create', urls: urls
      binding.pry
      expect(response.body).to include 'id'
    end
  end
end
