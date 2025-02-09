class AddCompany < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string  :name
      t.string  :industry
      t.boolean :active
      t.string  :contact_email
      t.string  :website

      t.timestamps
    end
  end
end
