require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'
require 'domainatrix'

class ImageCrawlerService
  VALID_FORMATS = ['.png', '.gif', '.jpg']
  DEEPEST_LEVEL = 1

  attr_reader :job, :results

  def initialize(urls: [], job_id:, level: 0)
    @urls_to_crawl = urls
    @job = Job.find(job_id)
    @level = level
    @results = {}

    job.update_attribute(:to_crawl, job.to_crawl + urls_to_crawl.count)
  end

  def crawl_urls
    urls_to_crawl.each do |url|
      @host = url
      @doc = Nokogiri::HTML(open(url, :allow_redirections => :all, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))

      results[host] = collect_images

      if level < DEEPEST_LEVEL
        external_urls = collect_urls
        children = ImageCrawlerService.new(urls: external_urls, job_id: job.id, level: level + 1)
        children.crawl_urls
        results.merge!(children.results)
      end

      adjust_progress_counts
    end

    job.update_attribute(:results, results.to_json)
  end

  private

  attr_reader :doc, :host, :level, :urls_to_crawl

  def collect_images
    img_tags = doc.css('img')

    found_images = img_tags.map do |img_tag|
      img_tag['src']
    end

    found_images.compact!
    found_images.uniq!
    found_images.reject! do |image|
      image_format = image[-4..-1]
      !VALID_FORMATS.include?(image_format)
    end

    found_images.map { |image| URI.join(host, image).to_s }
  end

  def collect_urls
    a_tags = doc.css('a')

    found_urls = a_tags.map do |a_tag|
      a_tag['href']
    end

    found_urls.compact!
    found_urls.uniq!
    found_urls.reject! do |found_url|
      if found_url[0] == '#' || found_url == '/'
        true
      else
        url = Domainatrix.parse(found_url)
        url.url == host ||
        url.url.include?('mailto:') ||
        (url.domain.blank? && url.path.blank?)
      end
    end

    found_urls.map { |url| URI.join(host, url).to_s }
  end

  def adjust_progress_counts
    job.reload
    job.update_attribute(:to_crawl, job.to_crawl - 1)
    job.update_attribute(:crawled, job.crawled + 1)
  end
end
