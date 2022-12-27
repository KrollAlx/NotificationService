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
        required: [ 'phone_number', 'operator_code', 'tag', 'timezone' ]
      }

      response(201, 'Client created') do
        let(:client) {{phone_number: '79559999999', operator_code: '32', tag: 'first client', timezone: 'Moscow'}}

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['phone_number']).to eq('79559999999')
          expect(data['operator_code']).to eq('32')
          expect(data['tag']).to eq('first client')
          expect(data['timezone']).to eq('Moscow')
        end
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
        required: [ 'phone_number', 'operator_code', 'tag', 'timezone' ]
      }

      response(200, 'Client updated') do
        let(:id) { Client.create(phone_number: '79559999999', operator_code: '32', tag: 'first client', timezone: 'Moscow').id}
        let(:client) { { phone_number: '79555555555', operator_code: '79', tag: 'updated client', timezone: 'Moscow'}}

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['phone_number']).to eq('79555555555')
          expect(data['operator_code']).to eq('79')
          expect(data['tag']).to eq('updated client')
          expect(data['timezone']).to eq('Moscow')
        end
      end

      response(404, 'Client not found') do
        let(:id) { -1 }
        let(:client) { { phone_number: '79559999999', operator_code: '32', tag: 'first client', timezone: 'Moscow'}}
        run_test!
      end

      response(422, 'Invalid request') do
        let(:id) { Client.create(phone_number: '79559999999', operator_code: '32', tag: 'first client', timezone: 'Moscow').id}
        let(:client) { { phone_number: '795b99a9999', operator_code: '32', tag: 'first client', timezone: 'Moscow'}}
        run_test!
      end
    end

    delete 'Delete client' do
      tags 'Clients'
      parameter name: :id, in: :path, type: :string
      produces 'application/json'

      response(200, 'Client deleted') do
        let(:id) { Client.create(phone_number: '79559999999', operator_code: '32', tag: 'first client', timezone: 'Moscow').id}
        run_test!
      end

      response(404, 'Client not found') do
        let(:id) { -1 }
        run_test!
      end
    end
  end
end
