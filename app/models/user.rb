# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Phonify

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  belongs_to :company
  has_many :sessions, as: :resource

  validates :first_name, :last_name, :email, presence: true
  validates :email, format: { with: Constants::EMAIL_REGEX }
  validates :encrypted_password, presence: true

  before_validation :set_default_password_and_set_primary, on: :create, if: ->(i) { i.password.blank? }
  before_save :default_primary, if: ->(i) { i.company.present? }
  before_save :set_primary, if: ->(i) { i.company_id.present? && primary_changed? && i.primary? }

  after_commit :send_welcome_email, on: :create

  def name
    "#{first_name} #{last_name}"
  end

  def set_default_password_and_set_primary
    self.password = SecureRandom.uuid

    self.primary = true if company.present? && company.primary_user.nil?
  end

  def send_welcome_email
    UserMailer.send_welcome_email(self).deliver_now
  end

  def send_test_sms
    SendSmsJob.perform_later(phone, "Welcome to GetRepo, #{name}!")
  end

  def set_primary
    user = User.where(company:, primary: true)
    user.update(primary: false) if user.present?
  end

  def default_primary
    return if company.primary_user.present?

    self.primary = true
  end
end
