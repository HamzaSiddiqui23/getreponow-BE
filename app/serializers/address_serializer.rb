# frozen_string_literal: true

class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :city, :state, :zip, :suite, :country
end
