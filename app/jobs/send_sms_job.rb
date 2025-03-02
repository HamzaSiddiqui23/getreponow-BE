# frozen_string_literal: true

class SendSmsJob < ApplicationJob
  queue_as :default

  def perform(phone, message)
    Services::SmsService.new.send_sms(phone, message)
  end
end
