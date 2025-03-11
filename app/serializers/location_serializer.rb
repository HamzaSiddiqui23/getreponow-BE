# frozen_string_literal: true

# == Schema Information
#
# Table name: locations
#
#  id                :bigint           not null, primary key
#  name              :string
#  active            :boolean
#  location_email    :string
#  google_review_url :string
#  company_id        :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :location_email, :google_review_url, :active
  has_one :address
end
