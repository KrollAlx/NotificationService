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
    result = UpdateClient.call(params)
    if result.success?
      client = result.success
      render json: client, status: :ok
    else
      if result.failure == 'Client not found'
        render json: result.failure, status: :not_found
      else
        render json: result.failure, status: :unprocessable_entity
      end
    end
  end

  def delete
  end
end
