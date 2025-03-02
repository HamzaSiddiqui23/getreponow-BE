# frozen_string_literal: true

class AddLocation < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string  :name
      t.boolean :active
      t.string  :location_email
      t.string :google_review_url
      t.references :company, index: true

      t.timestamps
    end
  end
end
