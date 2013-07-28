require "spec_helper"

describe Analytics::Client do
  context "#initialize" do
    it "raise error without token provided" do
      expect { Analytics::Client.new(nil) }.to raise_error
    end
  end

  context ".flush!" do
    it "should set nil to datas" do
      client = Analytics::Client.new('data')
      client.stubs(:request_accounts).returns([1, 2])
      ex = client.accounts
      client.flush!
      client.accounts.should == ex
    end
  end

  context ".accounts" do
    client = Analytics::Client.new('data')
    Analytics::Request.any_instance.stubs(:request).returns(MANAGEMENT_ACCOUNTS)
    client.accounts.count.should == 1
  end
end
