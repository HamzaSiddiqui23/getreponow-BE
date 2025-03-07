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

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :company
      row :primary
      row :created_at
      row :updated_at
    end
    panel 'Emails' do
      paginated_collection(
        resource.email_recipients.order(created_at: :desc).page(params[:page]).per(10), download_links: false
      ) do
        table_for collection do
          column :id
          column :email do |c|
            Constants::EMAIL_TEMPLATES.key(c.email.email_type)&.to_s&.humanize
          end
          column :created_at

          column 'Email Events' do |r|
            if r.email_events.any?
              table_for r.email_events.order(timestamp: :asc) do
                column :status
                column :timestamp
              end
            end
          end
        end
      end
    end
  end
end
