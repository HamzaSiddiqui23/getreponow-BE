# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id            :bigint           not null, primary key
#  resource_type :string           not null
#  resource_id   :bigint           not null
#  street        :string
#  suite         :string
#  city          :string
#  state         :string
#  zip           :string
#  country       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :city, :state, :zip, :suite, :country
end
