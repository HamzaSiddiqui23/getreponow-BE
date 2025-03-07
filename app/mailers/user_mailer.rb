# frozen_string_literal: true

# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def send_welcome_email(user)
    Services::EmailService.new.send_dynamic_email(user:, template_id: 'd-8df803d56f7c407cb862e8a56774b0c5',
                                                  subject: 'Welcome to Get Repo!', resource: user)
  end
end
