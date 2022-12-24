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
        start_notification = DateTime.now.to_s
        end_notification = (DateTime.now + 1.days).to_s

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

      response '422', 'invalid request' do
        start_notification = DateTime.now.to_s

        let(:notification) { { start_at: start_notification, end_at: "",
                               filter: '32', text: 'Hello world!'} }
        run_test!
      end
    end
  end
end
