require 'rails_helper'

describe ImageCrawlWorker do

  let(:urls) { ['https://www.statuspage.io'] }
  let(:job) { Job.create }

  it 'should add jobs to queue' do
    expect do
      ImageCrawlWorker.perform_async(urls, job.id)
    end.to change(ImageCrawlWorker.jobs, :size).by(1)
  end

  it 'should be in the default queue' do
    ImageCrawlWorker.perform_async(urls, job.id)

    expect(ImageCrawlWorker.jobs[0]['queue']).to eq('default')
  end

  it 'should have correct arguments' do
    ImageCrawlWorker.perform_async(urls, job.id)

    expect(ImageCrawlWorker.jobs[0]['args'][0]).to eq(urls)
    expect(ImageCrawlWorker.jobs[0]['args'][1]).to eq(job.id)
  end
end