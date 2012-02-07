require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {
      :email => "test@gmail.com",
      :password => "foobar",
      :password_confirmation => "foobar",
      :first_name => "Joe",
      :last_name => "Dude"
    }
  end
  
  it "should create user given valid input" do
    User.create!(@attr)
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:first_name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should reject name with symbols" do
    bad_name = User.new(@attr.merge(:first_name => "3oe"))
    bad_name.should_not be_valid
  end
  
  describe "password validations" do
    
    it "should reject passwords that don't match" do
      mismatch = User.new(@attr.merge(:password_confirmation => 'blah'))
      mismatch.should_not be_valid
    end
    
  end
  
  describe "authenticate method" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should return nil on email/password mismatch" do
      u = User.authenticate(@attr[:email], 'blah')
      u.should be_nil
    end
    
    it "should return user given correct login info" do
      u = User.authenticate(@attr[:email], @attr[:password])
      u.should == @user
    end
    
  end
  
end
