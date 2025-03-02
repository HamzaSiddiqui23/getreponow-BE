# frozen_string_literal: true

require 'csv'

module Api
  module V1
    class ContactsController < BaseController
      protect_from_forgery with: :null_session

      def index
        contacts = current_company.contacts
        render json: contacts
      end

      def show
        contact = current_company.contacts.find(params[:id])

        render json: contact
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Contact not found' }, status: :not_found
      end

      # POST /users
      def create
        contact = current_company.contacts.new(contact_params)

        if contact.save
          render json: contact, status: :created
        else
          render json: { error: contact.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /users/:id
      def update
        contact = current_company.contacts.find(params[:id])

        if contact.update(contact_params)
          render json: contact
        else
          render json: { error: contact.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Contact not found' }, status: :not_found
      end

      def upload_csv
        debugger
        if params[:file].present?
          file = params[:file]
          csv_text = file.read

          contacts = []
          CSV.parse(csv_text, headers: true) do |row|
            contacts << {
              first_name: row['first_name'],
              last_name: row['last_name'],
              email: row['email'],
              phone: row['phone']
            }
          end

          current_company.contacts.insert_all(contacts) # Bulk insert for efficiency

          render json: { message: 'Contacts imported successfully', count: contacts.size }, status: :created
        else
          render json: { error: 'No file uploaded' }, status: :unprocessable_entity
        end
      end

      # Strong parameters to ensure only permitted fields are passed
      def contact_params
        params.require(:contact).permit(:first_name, :last_name, :email, :phone) # Add any other fields as needed
      end
    end
  end
end
