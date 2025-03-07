# frozen_string_literal: true

class BlockedEmails < ActiveRecord::Migration[7.1]
  def change
    create_table  :blocked_emails do |t|
      t.string    :email, null: false
      t.string    :status, null: false
      t.string    :event, null: false

      t.timestamps
    end
  end
end
