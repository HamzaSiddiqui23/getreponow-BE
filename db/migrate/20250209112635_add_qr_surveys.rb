# frozen_string_literal: true

class AddQrSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :qr_surveys do |t|
      t.references  :location, index: true
      t.string      :service
      t.boolean     :show_logo
      t.string      :text_above
      t.string      :text_below

      t.timestamps
    end
  end
end
