class User < ApplicationRecord
  has_secure_password
  has_secure_token :token_reset
  has_one :user_extra, dependent: :destroy
  accepts_nested_attributes_for :user_extra
  attr_accessor :password_current, :require_password_current, :new_password,
                :new_password_confirmation, :skip_password

  extend FriendlyId
  friendly_id :name, use: :slugged
  default_scope { where(deleted: false) }
  validates :name, presence: true, length: { in: 2..30 }
  validates :password, :password_confirmation, presence: true, on: :create, unless: :skip_password
  validates :password, :password_confirmation, length: { in: 6..20 }, allow_blank: true
  validates :email, presence: true, email: true, uniqueness: {
    scope: :deleted, conditions: -> { where(deleted: false) }
  }

  validates :password_current, presence: true, if: :require_password_current
  validate :password_current_verify, if: :require_password_current
  after_validation :update_passowrd, if: :require_password_current

  before_create :generate_token

  def self.create_from_auth_hash(auth:)
    user = User.where(uid: auth.uid, provider: auth.provider).last
    unless user
      email = auth.info.email
      user = User.new
      user.name = auth.info.name
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = email || "#{auth.uid}@#{auth.provider}.com"
      user.credentials = auth.credentials
      user.skip_password = true
      user.password = SecureRandom.alphanumeric(10)
      user.status = 0
      user.save
    end
    user
  end

  private

  def password_current_verify
    errors.add(:password_current, 'Password is incorrect') unless authenticate(password_current)
  end

  def update_passowrd
    errors.add(:new_password_confirmation, 'Password is different') if new_password != new_password_confirmation
    self.password = new_password if new_password.present?
  end

  def generate_token
    self.token_reset = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Admin.exists?(token_reset: random_token)
    end
  end
end
