# frozen_string_literal: true

class Email < ApplicationRecord
  belongs_to :resource, polymorphic: true, optional: true
  has_many :email_recipients
end
