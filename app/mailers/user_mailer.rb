# frozen_string_literal: true

# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def send_welcome_email(user)
    Services::EmailService.new.send_dynamic_email(user:, template_id: '200000000166567',
                                                  subject: 'Welcome to Get Repo!')
  end
end
