class ImageCrawlWorker
  include Sidekiq::Worker

  def perform(urls)
    image_crawler = ImageCrawlerService.new(urls: urls)
    image_crawler.crawl_urls
    image_crawler.results
  end
end