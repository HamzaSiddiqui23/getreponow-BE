# frozen_string_literal: true

# == Schema Information
#
# Table name: admin_users
#
#  id                     :bigint           not null, primary key
#  first_name             :string           not null
#  last_name              :string           not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
