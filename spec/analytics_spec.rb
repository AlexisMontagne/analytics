require "spec_helper"

describe Analytics do
  before(:each) do
    Analytics.configure do |an|
      an.consumer_key = 'foo'
      an.consumer_secret = 'bar'
      an.default_access_token = OAuth2::AccessToken.new('','')
    end
  end
  
  context "#Configurable" do     
    context ".configure" do
      it "should persist credentials" do
        Analytics.consumer_secret.should == 'bar'
        Analytics.consumer_key.should == 'foo'
      end
    end

    context ".options" do
      it "should return a hash composed by both keys" do
        Analytics.options.class.should == Hash
        Analytics.options.fetch(:consumer_key).should == 'foo'
        Analytics.options.fetch(:consumer_secret).should == 'bar'
      end
    end
  end

  context ".client" do
    it "should be a Analytics::Client" do
      Analytics.client.class.should == Analytics::Client
    end

    it "should stay the same" do
      Analytics.client.should == Analytics.client
    end
  end

  it "forward methods to the client" do
    Analytics.client.stubs(:foo).returns(:bar)

    Analytics.client.foo.should == :bar
  end

  context '.access_token' do
    it "return the token if it's a access_token" do
      t = OAuth2::AccessToken.new(Analytics.oauth_client, 'foo-bar')
      Analytics.access_token(t).should == t
    end

    it "return the token build on the token given" do
      t = 'foo-bar'
      result = Analytics.access_token(t)
      result.class.should == OAuth2::AccessToken
      result.token.should == t
    end

    it "throw an error if no token provided" do
      expect { Analytics.access_token(nil) }.to raise_error(Analytics::Error::NoAccessTokenProvided)
    end
  end 

end
