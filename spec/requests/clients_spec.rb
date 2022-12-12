require 'swagger_helper'

RSpec.describe 'clients', type: :request do

  path '/clients' do

    post 'Create client' do
      tags 'Clients'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :client, in: :body, schema: {
        type: :object,
        properties: {
          phone_number: { type: :string },
          operator_code: { type: :string },
          tag: { type: :string },
          timezone: { type: :string }
        },
        required: [ 'phone_number', 'operator_code', 'tag', 'taimezone' ]
      }

      response(201, 'Client created') do
        # after do |example|
        #   example.metadata[:response][:content] = {
        #     'application/json' => {
        #       example: JSON.parse(response.body, symbolize_names: true)
        #     }
        #   }
        # end

        let(:client) {{phone_number: '79559999999', operator_code: '32', tag: 'first client', timezone: 'Moscow'}}
        run_test!
      end

      response(422, 'Invalid request') do
        let(:client) {{phone_number: '795b99a9999', operator_code: '32', tag: 'first client', timezone: 'Moscow'}}
        run_test!
      end
    end
  end

  path '/clients/{id}' do

    put 'Update client' do
      tags 'Clients'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :client, in: :body, schema: {
        type: :object,
        properties: {
          phone_number: { type: :string },
          operator_code: { type: :string },
          tag: { type: :string },
          timezone: { type: :string }
        },
        required: [ 'phone_number', 'operator_code', 'tag', 'taimezone' ]
      }

      response(200, 'Client updated') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/clients/{id}' do

    delete 'delete client' do
      tags 'Clients'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response(200, 'Client deleted') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
