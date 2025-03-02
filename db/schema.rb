# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_250_209_113_325) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.bigint 'resource_id'
    t.string 'author_type'
    t.bigint 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[author_type author_id], name: 'index_active_admin_comments_on_author'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index %w[resource_type resource_id], name: 'index_active_admin_comments_on_resource'
  end

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'addresses', force: :cascade do |t|
    t.string 'resource_type', null: false
    t.bigint 'resource_id', null: false
    t.string 'street'
    t.string 'suite'
    t.string 'city'
    t.string 'state'
    t.string 'zip'
    t.string 'country'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[resource_type resource_id], name: 'index_addresses_on_resource'
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'companies', force: :cascade do |t|
    t.string 'name'
    t.string 'industry'
    t.boolean 'active'
    t.string 'contact_email'
    t.string 'website'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'contacts', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.string 'email'
    t.string 'phone'
    t.boolean 'opt_out', default: false
    t.bigint 'company_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_contacts_on_company_id'
  end

  create_table 'locations', force: :cascade do |t|
    t.string 'name'
    t.boolean 'active'
    t.string 'location_email'
    t.string 'google_review_url'
    t.bigint 'company_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_locations_on_company_id'
  end

  create_table 'qr_surveys', force: :cascade do |t|
    t.bigint 'location_id'
    t.string 'service'
    t.boolean 'show_logo'
    t.string 'text_above'
    t.string 'text_below'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['location_id'], name: 'index_qr_surveys_on_location_id'
  end

  create_table 'sessions', force: :cascade do |t|
    t.string 'resource_type', null: false
    t.bigint 'resource_id', null: false
    t.string 'token', null: false
    t.datetime 'expires_at', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[resource_type resource_id], name: 'index_sessions_on_resource'
    t.index ['token'], name: 'index_sessions_on_token', unique: true
  end

  create_table 'survey_recipients', force: :cascade do |t|
    t.bigint 'survey_id'
    t.bigint 'contact_id'
    t.string 'status'
    t.datetime 'sent_at', precision: nil
    t.datetime 'opened_at', precision: nil
    t.datetime 'clicked_at', precision: nil
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['contact_id'], name: 'index_survey_recipients_on_contact_id'
    t.index ['survey_id'], name: 'index_survey_recipients_on_survey_id'
  end

  create_table 'survey_responses', force: :cascade do |t|
    t.bigint 'survey_recipient_id'
    t.string 'status'
    t.integer 'rating'
    t.string 'comments'
    t.boolean 'qr_response'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['survey_recipient_id'], name: 'index_survey_responses_on_survey_recipient_id'
  end

  create_table 'survey_templates', force: :cascade do |t|
    t.bigint 'survey_id'
    t.integer 'subject'
    t.string 'header'
    t.string 'message', null: false
    t.string 'footer'
    t.string 'type', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['survey_id'], name: 'index_survey_templates_on_survey_id'
  end

  create_table 'surveys', force: :cascade do |t|
    t.bigint 'location_id'
    t.integer 'threshold', default: 3, null: false
    t.string 'form_message'
    t.string 'good_message'
    t.string 'negative_message'
    t.string 'enabled', default: 'f'
    t.string 'white_label', default: 'f'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['location_id'], name: 'index_surveys_on_location_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.string 'phone'
    t.bigint 'company_id'
    t.boolean 'primary', default: false, null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_users_on_company_id'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
end
