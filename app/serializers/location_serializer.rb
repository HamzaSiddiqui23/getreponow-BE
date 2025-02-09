class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :location_email, :google_review_url, :active
  has_one :address
end