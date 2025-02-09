class Session < ApplicationRecord

  belongs_to :resource, polymorphic: true

  before_validation :set_token_and_expiration, on: :create

  scope :active, -> { where('expires_at > ?', Time.current) }
  scope :user_session, ->(user) { where(resource: user) }
  
  def user
    resource if resource.is_a?(User)
  end

  def expire
    return if expires_at < Time.current

    update(expires_at: Time.current)
  end

  def self.upsert_session_for_resource(resource, expiration_time: 1.month)
    session = Session.active.find_or_initialize_by(resource:)
    session.update(expires_at: expiration_time.from_now)
    session
  end

  def generate_jwt
    JwtToken.encode(token)
  end

  def set_token_and_expiration
    self.expires_at ||= 1.month.from_now

    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Session.exists?(token: random_token)
    end
  end
end
