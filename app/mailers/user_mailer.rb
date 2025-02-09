# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer

  SENDER_ADDRESS = 'support@getreponow.com'

  def send_dynamic_email(user, template_id, dynamic_data)
    from = SendGrid::Email.new(email: SENDER_ADDRESS)
    to = SendGrid::Email.new(email: user.email)

    mail = SendGrid::Mail.new
    mail.from = from
    mail.template_id = template_id

    personalization = SendGrid::Personalization.new
    personalization.add_to(to)
    personalization.add_dynamic_template_data(dynamic_data)

    mail.add_personalization(personalization)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)

    puts response.status_code
    puts response.body
    puts response.headers
  end
end