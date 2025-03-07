# frozen_string_literal: true

# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def send_welcome_email(user)
    Services::EmailService.new.send_dynamic_email(user:, template_id: Constants::EMAIL_TEMPLATES[:welcome_email],
                                                  subject: 'Welcome to Get Repo!', resource: user)
  end
end
