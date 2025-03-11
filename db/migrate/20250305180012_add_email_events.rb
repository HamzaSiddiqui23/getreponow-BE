# frozen_string_literal: true

class AddEmailEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :email_events do |t|
      t.references :recipient, polymorphic: true, null: false
      t.string     :status, null: false
      t.datetime   :timestamp, null: false

      t.timestamps
    end
  end
end
