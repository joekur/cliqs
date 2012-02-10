class User < ActiveRecord::Base
  include RegexHelper
  
  has_many :cliq_memberships, :dependent => :destroy
  has_many :cliqs, :through => :cliq_memberships
  
  
  validates :email, :presence => true,
                    :format => { :with => $email_regex },
                    :uniqueness => { :case_sensitive => false }
  
  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => { :within => 6..40 }
  
  validates :first_name,  :presence => true,
                          :format => { :with => $az_regex }
  
  validates :last_name,  :presence => true,
                         :format => { :with => $az_regex }
  
  
  before_save :encrypt_password, :only => :create
  
  
  def has_password? (submitted_password)
    self.password == encrypt(submitted_password)
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
      if !self.password.nil?
        self.password = encrypt(self.password)
      end
    end
    
    def encrypt(string)
      Digest::SHA2.hexdigest("#{@cliqs_salt}--#{string}")
    end
  
end