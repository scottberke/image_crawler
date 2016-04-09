FactoryGirl.define do
  factory :job do
    to_crawl      0
    crawled       0
  end


  trait :with_results do
    to_crawl      0
    crawled       1
    results         "{\"#{Faker::Internet.url}\":[\"#{Faker::Internet.url}\"]}"
  end
end

