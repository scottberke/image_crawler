class JobsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    urls = params[:urls]
    job = Job.create

    ImageCrawlWorker.perform_async(urls, job.id)

    render json: { id: job.id }, status: 202
  end
end