# frozen_string_literal: true

class AddEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :emails do |t|
      t.references :resource, polymorphic: true, null: true
      t.string :email_type
      t.timestamps
    end
  end
end
