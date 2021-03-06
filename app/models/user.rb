require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions, dependent: :destroy

  validates :email, :username, presence:true
  validates :email, :username, uniqueness:true
  validates :username, length: { maximum: 40 }
  validates :email, email: true
  validates :username, format: { with: /\A\w+\z/,
                                 message: 'Only allows letters, numbers and character "_"' }
  validates :color, format: { with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/i,
                              message: 'Must be a valid CSS hex color code' }

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_validation :username_downcase
  before_save :encrypt_password

  def username_downcase
    username.downcase!
  end

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(
              password, password_salt, ITERATIONS, DIGEST.length, DIGEST
          )
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
            password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
    )

    return user if user.password_hash == hashed_password

    nil
  end
end
