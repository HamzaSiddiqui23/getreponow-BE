# frozen_string_literal: true

class Constants
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  EMAIL_TEMPLATES = {
    welcome_email: 'd-8df803d56f7c407cb862e8a56774b0c5'
  }.freeze
end
