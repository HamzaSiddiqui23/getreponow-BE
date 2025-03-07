# frozen_string_literal: true

require 'sendgrid-ruby'

module Services
  class EmailService
    include SendGrid

    SENDER_ADDRESS = 'support@getreponow.com'

    def initialize
      @headers = {
        'Authorization' => "App #{ENV['INFOBIP_API_KEY']}",
        'Accept' => 'application/json'
      }
    end

    def send_dynamic_email(user:, template_id:, subject:, resource:)
      return if BlockedEmail.where(email: user.email).present?

      email = ::Email.create!(resource:, email_type: template_id)
      recipient = EmailRecipient.create!(recipient: user, email:, recipient_email: user.email)

      to_email = Email.new(email: user.email)
      from_email = Email.new(email: SENDER_ADDRESS)
      mail = Mail.new
      mail.from = from_email
      mail.subject = subject

      personalization = Personalization.new
      personalization.add_to(to_email)
      personalization.add_dynamic_template_data({
                                                  name: user.name
                                                })

      personalization.add_custom_arg(CustomArg.new(key: 'email_id', value: recipient.id.to_s))
      mail.add_personalization(personalization)

      mail.template_id = template_id

      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      response = sg.client.mail._('send').post(request_body: mail.to_json)

      Rails.logger.info("SendGrid Response: #{response.status_code} - #{response.body}")
    end
  end
end
