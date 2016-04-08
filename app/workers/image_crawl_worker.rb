class ImageCrawlWorker
  include Sidekiq::Worker

  def perform(urls, job_id)
    image_crawler = ImageCrawlerService.new(urls: urls, job_id: job_id)
    image_crawler.crawl_urls
  end
end