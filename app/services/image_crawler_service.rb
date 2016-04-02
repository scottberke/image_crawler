class ImageCrawlerService

  attr_reader :urls

  def initialize(urls:)
    @urls = urls
  end
end


# TODO:
# - validate urls is passed in as an array
# - validate each url is a valid url
# - report on status of urls
# - collect errors