# frozen_string_literal: true

class AddSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :surveys do |t|
      t.references :location,         index: true
      t.integer    :threshold,        null: false, default: 3
      t.string     :form_message
      t.string     :good_message
      t.string     :negative_message
      t.string     :enabled,          default: false
      t.string     :white_label,      default: false

      t.timestamps
    end
  end
end
