class AddContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string      :first_name,  null: false
      t.string      :last_name,   null: false
      t.string      :email
      t.string      :phone
      t.boolean     :opt_out,     default: false
      t.references  :company,     index: true

      t.timestamps
    end
  end
end
