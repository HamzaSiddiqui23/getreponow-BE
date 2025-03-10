# frozen_string_literal: true

class AddSession < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.references :resource,       null: false, index: true, polymorphic: true
      t.string :token,              null: false, index: { unique: true }
      t.datetime :expires_at,       null: false

      t.timestamps
    end
  end
end
