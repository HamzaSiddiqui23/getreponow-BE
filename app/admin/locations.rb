# frozen_string_literal: true

ActiveAdmin.register Location do
  show do
    attributes_table do
      row :name
      row :company
      row :location_email
      row :google_review_url
      row :active
      row :created_at
      row :updated_at

      table_for location.address do
        column :street
        column :suite
        column :state
        column :zip
        column :country
      end
    end
  end
end
