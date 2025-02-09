class AddAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :resource, null: false, index: true, polymorphic: true
      t.string :street
      t.string :suite
      t.string :city
      t.string :state
      t.string :zip
      t.string :country

      t.timestamps
    end
  end
end
