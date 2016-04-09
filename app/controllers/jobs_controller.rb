class JobsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    urls = params[:urls]
    job = Job.create

    ImageCrawlWorker.perform_async(urls, job.id)

    render json: { id: job.id }, status: 202
  end

  def status
    job = Job.find(params[:id]) or not_found

    response = { id: job.id,
                 status: {
                  completed: job.crawled,
                  inprogress: job.to_crawl } }

    render json: response
  end

  def results
    job = Job.find(params[:id]) or not_found

    response = { id: job.id,
             results: JSON.parse(job.results) }

    render json: response
  end

  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
