# frozen_string_literal: true

module Phonify
  extend ActiveSupport::Concern

  included do
    validates :phone, phone: true, allow_blank: true
    before_save :normalize_phone

    def formatted_phone
      return '' unless parsed.local_number.present?

      "+#{parsed.country_code} #{parsed.local_number}"
    end

    private

    def parsed
      Phonelib.parse(phone)
    end

    def normalize_phone
      self.phone = Phonelib.parse(phone).full_e164.presence
    end
  end
end
