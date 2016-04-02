class JobsController < ApplicationController


  def create
    render json: {}, status: 202
  end
end