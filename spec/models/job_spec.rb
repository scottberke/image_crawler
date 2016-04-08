require 'rails_helper'

describe Job do

  subject { Job.new }

  it { is_expected.to respond_to :results }
  it { is_expected.to respond_to :to_crawl }
  it { is_expected.to respond_to :crawled }
  it { is_expected.to respond_to :sidekiq_jid }

end
