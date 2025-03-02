# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :company_id, :first_name, :last_name, :email, :phone, :primary

  filter :company
  filter :first_name
  filter :last_name
  filter :email

  index do
    selectable_column
    id_column
    column :name
    column :company
    column :email
    actions
  end

  form do |f|
    f.inputs do
      f.input :company
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
      f.input :primary
    end

    f.actions
  end
end
