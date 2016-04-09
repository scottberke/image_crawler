require 'rails_helper'

describe ImageCrawlerService do
  let(:urls) { ['https://www.statuspage.io'] }
  let(:job) { Job.create }
  let(:image_crawler) { ImageCrawlerService.new(urls: urls, job_id: job.id) }

  describe '.new' do
    it 'initializes correctly' do
      expect(image_crawler).to be_a ImageCrawlerService
      expect(image_crawler.job).to eq job
    end
  end

  describe '#crawls_urls' do
    it 'crawls through urls' do
      VCR.use_cassette('statuspage', :record => :new_episodes) do
        expect(job.crawled).to eq 0

        image_crawler.crawl_urls

        job.reload
        expect(job.crawled).to be > 0
      end
    end

    it 'saves results to job results' do
      VCR.use_cassette('statuspage', :record => :new_episodes) do
        expect(job.results).to be_nil

        image_crawler.crawl_urls

        job.reload
        expect(image_crawler.results).to eq JSON.parse(job.results)
      end
    end
  end

  describe '#results' do
    let(:results) do
     image_crawler.crawl_urls
     image_crawler.results
    end

    it 'returns results in expected format' do
      VCR.use_cassette('statuspage', :record => :new_episodes) do
        expect(results).to be_a Hash
        expect(results).to have_key urls.first
      end
    end

    it 'returns results with only valid formats' do
      VCR.use_cassette('statuspage', :record => :new_episodes) do
        valid_formats = ['.png', '.gif', '.jpg']

        results.each do |host, images|
          images.each do |image|
            image_format = image[-4..-1]
            expect(valid_formats.include?(image_format)).to eq true
          end
        end
      end
    end
  end
end