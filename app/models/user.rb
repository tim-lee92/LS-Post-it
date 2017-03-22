class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  validates :username, presence: true, uniqueness: {:case_sensitive => false}
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  before_save :generate_slug

  def to_param
    self.slug
  end

  def generate_slug
    self.slug = self.username.gsub(" ", "-").downcase
  end

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end

  def two_factor_auth?
    !self.phone.blank?
  end

  def save_pin(pin)
    self.update_column(:pin, pin)
  end

  def remove_pin
    self.update_column(:pin, nil)
  end

  def send_pin_to_twilio
    # account_sid = <hidden>
    # auth_token = <hidden>
    #
    # # set up a client to talk to the Twilio REST API
    # client = Twilio::REST::Client.new account_sid, auth_token
    #
    # msg = "Please enter the following pin to continue two-factor-authentication login: #{self.pin}"
    # client.account.messages.create({
    #   :to => self.phone,
    #   :from => <hidden>
    #   :body => msg,
    # })
  end
end
