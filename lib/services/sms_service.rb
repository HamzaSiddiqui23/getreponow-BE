# frozen_string_literal: true

require 'httparty'

module Services
  class SmsService
    include HTTParty
    base_uri 'https://api.infobip.com/sms/2/text/advanced'

    def initialize
      @headers = {
        'Authorization' => "App #{Rails.application.credentials.dig(:infobip, :api_key)}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    end

    def send_sms(to, message)
      options = {
        headers: @headers,
        body: {
          messages: [
            {
              destinations: [{ to: to }],
              text: message,
              from: '447491163443' # Change this to a registered sender ID if required
            }
          ]
        }.to_json
      }

      response = self.class.post('', options)
      response.parsed_response
    end
  end
end
