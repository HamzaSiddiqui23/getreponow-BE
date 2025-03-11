# frozen_string_literal: true

# == Schema Information
#
# Table name: emails
#
#  id            :bigint           not null, primary key
#  resource_type :string
#  resource_id   :bigint
#  email_type    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Email < ApplicationRecord
  belongs_to :resource, polymorphic: true, optional: true
  has_many :email_recipients
end
