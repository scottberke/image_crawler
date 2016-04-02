require 'spec_helper'

describe ImageCrawlerService do
  let(:urls) { ['https://www.statuspage.io'] }

  describe '.new' do
    let(:image_crawler) { ImageCrawlerService.new(urls: urls) }

    it 'initializes correctly' do
      expect(image_crawler).to be_a ImageCrawlerService
      expect(image_crawler.urls).to eq urls
    end
  end

  describe '#parse_urls' do

  end
end