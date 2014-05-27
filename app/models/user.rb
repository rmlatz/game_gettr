class User < ActiveRecord::Base

  has_many :additions, dependent: :destroy
  has_many :games, through: :additions

  # It validates the email field.
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  # It validates the user has a secure password.
  has_secure_password

  # Defines the method used to create a new remember token for the user.
  def User.new_remember_token
    # Creates a 64bit random remember_token.
    SecureRandom.urlsafe_base64
  end

  # Defines the method used for hashing a plaintext remember token
  def User.hash(token)
    # Creates a hash and converts it to a string.
    Digest::SHA1.hexdigest(token.to_s)
  end

  # def add(game)
    #Addition.create(user_id: self.id, song_id: song.id)
    #games << game
  # end

  private

  # Creates a new session token for the user:
  def create_remember_token
    self.remember_token = User.hash(User.new_remember_token)
  end

  # Makes sure firelds are of the proper formatting to avoid conflicts.
  def normalize_fields
    self.email.downcase!
  end

end
