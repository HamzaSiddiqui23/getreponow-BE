# frozen_string_literal: true

class SendgridController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    events = JSON.parse(request.body.read)

    events.each do |event|
      email = event['email']
      event_type = event['event']
      timestamp = Time.at(event['timestamp'])

      email_id = event['email_id']
      email_recipient = EmailRecipient.find(email_id)

      # Log the event (or store it in the database)
      Rails.logger.info "SendGrid Event: #{event_type} for #{email} at #{timestamp}"

      EmailEvent.create!(email_recipient:, status: event_type, timestamp:)
    end

    head :ok
  end
end
