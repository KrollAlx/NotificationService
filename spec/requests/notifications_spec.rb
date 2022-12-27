require 'swagger_helper'

RSpec.describe 'notifications', type: :request do
  path '/notifications' do

    post 'Create notification' do
      tags 'Notifications'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :notification, in: :body, schema: {
        type: :object,
        properties: {
          start_at: { type: :string },
          text: { type: :string },
          filter: { type: :string },
          end_at: { type: :string }
        },
        required: [ 'start_at', 'text', 'filter', 'end_at' ]
      }

      response '201', 'Notification created' do
        start_notification = (DateTime.now - 1.days).to_s
        end_notification = (DateTime.now - 2.days).to_s

        let(:notification) { { start_at: start_notification, end_at: end_notification,
                               filter: '32', text: 'Hello world!'} }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['start_at'].to_datetime.localtime).to eq(start_notification.to_datetime)
          expect(data['end_at'].to_datetime.localtime).to eq(end_notification.to_datetime)
          expect(data['filter']).to eq('32')
          expect(data['text']).to eq('Hello world!')
        end
      end

      response '422', 'Invalid request' do
        start_notification = DateTime.now.to_s

        let(:notification) { { start_at: start_notification, end_at: '',
                               filter: '32', text: 'Hello world!'} }
        run_test!
      end
    end
  end

  path '/notifications/{id}' do
    put 'Update notification' do
      tags 'Notifications'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :notification, in: :body, schema: {
        type: :object,
        properties: {
          start_at: { type: :string },
          text: { type: :string },
          filter: { type: :string },
          end_at: { type: :string }
        },
        required: [ 'start_at', 'text', 'filter', 'end_at' ]
      }

      response '200', 'Notification updated' do
        start_notification = (DateTime.now - 1.days).to_s
        end_notification = (DateTime.now - 2.days).to_s

        let(:id) { Notification.create(start_at: start_notification, end_at: end_notification,
                                                 filter: '32', text: 'Hello world!').id}
        let(:notification) { {start_at: start_notification, end_at: end_notification,
                              filter: '99', text: 'Hello world!'} }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['start_at'].to_datetime.localtime).to eq(start_notification.to_datetime)
          expect(data['end_at'].to_datetime.localtime).to eq(end_notification.to_datetime)
          expect(data['filter']).to eq('99')
          expect(data['text']).to eq('Hello world!')
        end
      end

      response '422', 'Invalid request' do
        start_notification = (DateTime.now - 1.days).to_s
        end_notification = (DateTime.now - 2.days).to_s

        let(:id) { Notification.create(start_at: start_notification, end_at: end_notification,
                                       filter: '32', text: 'Hello world!').id}
        let(:notification) { {start_at: start_notification, end_at: '',
                              filter: '99', text: 'Hello world!'} }

        run_test!
      end

      response '404', 'Notification not found' do
        start_notification = (DateTime.now - 1.days).to_s
        end_notification = (DateTime.now - 2.days).to_s

        let(:notification) { {start_at: start_notification, end_at: end_notification,
                              filter: '99', text: 'Hello world!'} }
        let(:id) { -1 }

        run_test!
      end
    end

    delete 'Delete notification' do
      tags 'Notifications'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Notification deleted' do
        start_notification = (DateTime.now - 1.days).to_s
        end_notification = (DateTime.now - 2.days).to_s

        let(:id) { Notification.create(start_at: start_notification, end_at: end_notification,
                                       filter: '32', text: 'Hello world!').id}

        run_test!
      end

      response '404', 'Notification not found' do
        let(:id) { -1 }
        run_test!
      end
    end
  end

  path '/notifications/statistics' do

    get 'Get statistics' do
      tags 'Notifications'
      produces 'application/json'

      response '200', 'OK' do
        start_notification = (DateTime.now - 1).to_s
        end_notification = (DateTime.now - 2.days).to_s

        Client.create(phone_number: '79559999999', operator_code: '32', tag: 'first client', timezone: 'Moscow')
        Client.create(phone_number: '79559999944', operator_code: '32', tag: 'second client', timezone: 'Moscow')

        CreateNotification.call({ start_at: start_notification, end_at: end_notification,
                                                filter: '32', text: 'Hello world!'}).success

        run_test! do |response|
          data = JSON.parse(response.body)[0]
          expect(data['filter']).to eq('32')
          expect(data['text']).to eq('Hello world!')
          expect(data['messages']).to eq([])
        end
      end
    end
  end

  path '/notifications/{id}/statistics' do

    get 'Get notification details' do
      tags 'Notifications'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'OK' do
        start_notification = (DateTime.now - 1).to_s
        end_notification = (DateTime.now - 2.days).to_s

        Client.create(phone_number: '79559999999', operator_code: '32', tag: 'first client', timezone: 'Moscow')
        Client.create(phone_number: '79559999944', operator_code: '32', tag: 'second client', timezone: 'Moscow')

        notification = CreateNotification.call({ start_at: start_notification, end_at: end_notification,
                                  filter: '32', text: 'Hello world!'}).success

        let(:id) { notification.id }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['filter']).to eq('32')
          expect(data['text']).to eq('Hello world!')
          expect(data['messages']).to eq([])
        end
      end
    end
  end
end
