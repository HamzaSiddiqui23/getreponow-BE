# frozen_string_literal: true

class AddSurveyResponse < ActiveRecord::Migration[7.1]
  def change
    create_table :survey_responses do |t|
      t.references  :survey_recipient, index: true
      t.string      :status
      t.integer     :rating
      t.string      :comments
      t.boolean     :qr_response

      t.timestamps
    end
  end
end
