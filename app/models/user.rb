class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::JTIMatcher

  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_many :tasks, dependent: :destroy

  before_create :set_jti

  def jwt_payload
    { "jti" => jti }
  end

  def generate_refresh_token
    SecureRandom.hex(32)
  end

  private

  def set_jti
    self.jti = SecureRandom.uuid
  end
end
