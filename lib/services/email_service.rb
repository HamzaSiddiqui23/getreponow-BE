# frozen_string_literal: true

require 'httparty'

module Services
  class EmailService
    include HTTParty

    SENDER_ADDRESS = 'support@getreponow.com'
    base_uri 'https://api.infobip.com/email/3/send'

    def initialize
      @headers = {
        'Authorization' => "App #{ENV['INFOBIP_API_KEY']}",
        'Accept' => 'application/json'
      }
    end

    def send_dynamic_email(user:, template_id:, subject:)
      options = {
        headers: @headers,
        body: {
          from: SENDER_ADDRESS,
          to: [{ to: user.email, placeholders: { name: user.name } }.to_json],
          subject: subject,
          templateid: template_id
        },
        multipart: true
      }

      response = self.class.post('', options)
      response.parsed_response
    end
  end
end
