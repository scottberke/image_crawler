class JobsController < ApplicationController


  def create

    render json: { id: 1 }, status: 202
  end
end