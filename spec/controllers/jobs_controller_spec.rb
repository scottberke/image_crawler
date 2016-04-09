require 'rails_helper'

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
      expect(response.body).to include 'id'
    end
  end

  describe 'GET status' do
    let(:job) { FactoryGirl.create(:job, :with_results) }

    it 'returns http status 200' do
      get 'status', id: job.id
      expect(response.status).to eq 200
    end

    it 'returns json content type' do
      get 'status', id: job.id
      expect(response.content_type).to eq "application/json"
    end

    it 'retreives the count status for a job' do
      get 'status', id: job.id

      expected_response = { id: job.id,
                            status: {
                              completed: job.crawled,
                              inprogress: job.to_crawl }
                          }

      expect(response.body).to eq expected_response.to_json
    end
  end

  describe 'GET results' do
    let(:job) { FactoryGirl.create(:job, :with_results) }

    it 'returns http status 200' do
      get 'results', id: job.id
      expect(response.status).to eq 200
    end

    it 'returns json content type' do
      get 'results', id: job.id
      expect(response.content_type).to eq "application/json"
    end

    it 'returns results' do
      get 'results', id: job.id

      expected_response = { id: job.id,
                            results: JSON.parse(job.results) }

      expect(response.body).to eq expected_response.to_json
    end
  end
end
