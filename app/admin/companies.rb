ActiveAdmin.register Company do
  permit_params :name, :industry, :logo, address_attributes: [:id, :street, :city, :suite, :state, :zip, :country, :_destroy], locations_attributes: [:id, :name, :location_email, :active, :_destroy, address_attributes: [:id, :street, :city, :suite, :state, :zip, :country, :_destroy]]

  filter :name

  action_item :import_contacts, only: :show do
    link_to 'Import Contacts', import_contacts_admin_company_path(resource), method: :get
  end

  member_action :import_contacts, method: :get do
    render 'admin/companies/import_csv', layout: 'active_admin'
  end

  collection_action :process_csv, method: :post do
    company = Company.find(params[:company_id])
    
    if params[:file].present?
      require 'csv'

      CSV.foreach(params[:file].path, headers: true) do |row|
        company.contacts.create(row.to_h)
      end

      redirect_to admin_company_path(company), notice: "Contacts imported successfully!"
    else
      redirect_to import_contacts_admin_company_path(company), alert: "Please upload a valid CSV file."
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :industry
    column :active
    actions
  end

  show do
    columns do
      column do
        attributes_table do
          row :logo do |r|
            image_tag(rails_blob_path(r.logo, disposition: 'logo'), height: 50) if r.logo.attached?
          end
          row :name
          row :industry
          row :contact_email
          row :website
          row :active
          row :created_at
          row :updated_at

          table_for company.address do
            column :street
            column :suite
            column :state
            column :zip
            column :country
          end
        end
        active_admin_comments 
      end

      column do
        panel 'Locations' do
          paginated_collection(
            resource.locations.page(params[:page]).per(10), download_links: false
          ) do
            table_for collection do
              column :id
              column :name do |l|
                link_to l.name, "#{admin_locations_path}/#{l.id}"
              end
              column :active
              column :location_email
            end
          end
        end

        panel 'Users' do
          paginated_collection(
            resource.users.page(params[:page]).per(10), download_links: false
          ) do
            table_for collection do
              column :id
              column :first_name do |u|
                link_to u.first_name, "#{admin_users_path}/#{u.id}"
              end
              column :last_name
              column :email
              column :phone
              column :primary
            end
          end
        end
      end
    end
  end

  form do |f|
    f.semantic_errors(*f.object.errors.to_hash.keys)
    f.inputs do
      f.input :name
      f.input :logo, as: :file
      f.input :industry

      f.has_many :address, heading: 'Address', allow_destroy: true, new_record: true, class: 'has_one' do |a|
        a.input :street
        a.input :suite
        a.input :city
        a.input :state
        a.input :zip
        a.input :country, as: :select, collection: ['US', 'Canada']
      end

      f.has_many :locations, heading: 'Location', allow_destroy: true, new_record: true do |l|
        l.input :name
        l.input :location_email
        l.input :active
        l.input :google_review_url

        l.has_many :address, heading: 'Address', allow_destroy: true, new_record: true, class: 'has_one' do |a|
          a.input :street
          a.input :suite
          a.input :city
          a.input :state
          a.input :zip
          a.input :country, as: :select, collection: ['US', 'Canada']
        end
      end
    end

    f.actions
  end
end