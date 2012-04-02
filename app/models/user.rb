class User < ActiveRecord::Base
  include RegexHelper
  
  has_many :cliq_memberships, :dependent => :destroy
  has_many :cliqs, :through => :cliq_memberships
  has_many :posts
  has_many :comments
  has_many :profiles
  has_many :photos
  
  
  validates :email, :presence => true,
                    :format => { :with => $email_regex },
                    :uniqueness => { :case_sensitive => false }
  
  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => { :within => 6..40 },
                        :if => :password_required?
  
  validates :first_name,  :presence => true,
                          :format => { :with => $az_regex }
  
  validates :last_name,  :presence => true,
                         :format => { :with => $az_regex }

  accepts_nested_attributes_for :cliq_memberships
  attr_accessor :password, :password_confirmation
  attr_accessible :email, :first_name, :last_name, :how_to_box, :cliq_memberships_attributes, :password, :password_confirmation
  
  before_save :encrypt_password
  
  
  def has_password? (submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  private #-----------------------------------------------------------------------
    
    @cliqs_salt = "JLfdj8292hFJ3L83hasFH8a23320Fijds"
    
    def encrypt_password
      if self.password.present?
        self.encrypted_password = encrypt(self.password)
      end
    end
    
    def encrypt(string)
      Digest::SHA2.hexdigest("#{@cliqs_salt}--#{string}")
    end

    def password_required?
      self.password.present? || self.password_confirmation.present?
    end

  
end