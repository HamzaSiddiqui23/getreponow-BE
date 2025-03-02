# frozen_string_literal: true

class AddSurveyRecipient < ActiveRecord::Migration[7.1]
  def change
    create_table :survey_recipients do |t|
      t.references :survey,         index: true
      t.references :contact,        index: true
      t.string     :status
      t.timestamp  :sent_at
      t.timestamp  :opened_at
      t.timestamp  :clicked_at

      t.timestamps
    end
  end
end
