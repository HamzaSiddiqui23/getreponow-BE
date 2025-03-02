# frozen_string_literal: true

class AddSurveyTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :survey_templates do |t|
      t.references :survey, index: true
      t.integer    :subject
      t.string     :header
      t.string     :message, null: false
      t.string     :footer
      t.string     :type, null: false

      t.timestamps
    end
  end
end
