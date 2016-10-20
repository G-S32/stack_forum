class User < ActiveRecord::Base
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true
  validates :encrypted_password, :confirmation => true #password_confirmation attr
  validates_length_of :encrypted_password, :in => 6..20, :on => :create

  before_create :set_access_token
private
      def set_access_token
      self.token = generate_token
    end
    
    def generate_token
      loop do
        token = SecureRandom.hex(10)
        break token unless User.where(token: token).exists?
      end
    end

end
