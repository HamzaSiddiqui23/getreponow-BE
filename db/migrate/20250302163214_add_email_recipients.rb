# frozen_string_literal: true

class AddEmailRecipients < ActiveRecord::Migration[7.1]
  def change
    create_table :email_recipients do |t|
      t.references :recipient, polymorphic: true, null: false
      t.string     :recipient_email, null: false
      t.references :email, index: true, null: false
      t.timestamps
    end
  end
end
