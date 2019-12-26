class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  ## RelationShip
  has_many :auth_tokens, dependent: :destroy

  ## Validation
  validates :email, format: {
    with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  }
  validate :password_complexity

  def password_complexity
    if password.present? && !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/)
      errors[:base] << 'Minimum 8 character, At least 1 capital, '+
            '1 alphabet & 1 number required. Special character not allow.'
    end
  end

  ## Generate Auth token when user login
  def generate_auth_token
    begin
      token = SecureRandom.hex
    end while AuthToken.exists?(auth_token: token)
    self.auth_tokens.create(auth_token: token)
    token
  end

  def deliver_password_reset_instructions
    begin
      token = SecureRandom.hex(25)
    end while User.exists?(reset_password_token: token)
    self.reset_password_token = token
    self.reset_password_sent_at = "#{Time.now}"
    self.save(validate: false)
    send_reset_password_instructions_notification(token)
  end

  ## Devise Default method override
  def send_reset_password_instructions_notification(token)
    send_devise_notification(:reset_password_instructions, token, {})
  end
end
