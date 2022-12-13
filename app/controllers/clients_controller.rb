class ClientsController < ApplicationController
  def create
    result = CreateClient.call(params)
    if result.success?
      client = result.success
      render json: client, status: :created
    else
      render json: result.failure, status: :unprocessable_entity
    end
  end

  def update
  end

  def delete
  end
end
