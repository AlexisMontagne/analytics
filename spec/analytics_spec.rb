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
end
