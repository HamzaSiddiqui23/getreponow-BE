# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :resource, polymorphic: true

  def complete?
    street? && city? && state && country? && zip
  end
end
