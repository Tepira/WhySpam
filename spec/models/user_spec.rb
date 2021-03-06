require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do 
  
  describe "password reset" do
    before(:each) do
      @user = User.new
      @user.stubs(:reset_perishable_token!)
      Notifier.stubs(:deliver_password_reset_instructions)
    end
    
    
    it "should be able to create an account with no password" do
      ## TODO write tests, make sure when the user resets the password, it doesn't default to email
      user = Factory.create(:user, :password => nil)
      puts user.email
      user.save
      user.email.should == user.password
      user.should be_valid      
      
    end
    
    it "should be able to create an account with no login" do
      ## TODO write tests, make sure when the user resets the password, it doesn't default to emai
   #   user = Factory.create(:user, :login => nil)
   user = Factory.create(:user, :password => nil)
      user.save
      user.should be_valid
    end
    
    it "should reset the perishable token" do
      @user.expects(:reset_perishable_token!)
      @user.deliver_password_reset_instructions!
    end
    
    it "should deliver reset instructions" do
      Notifier.expects(:deliver_password_reset_instructions).with(@user)
      @user.deliver_password_reset_instructions!      
    end
  end
end