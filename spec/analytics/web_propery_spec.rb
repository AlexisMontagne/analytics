require "spec_helper"

describe Analytics::WebProperty do
  context ".profiles" do
    it "should return a list of profile" do
      client = Analytics::WebProperty.new({
         "id" => 'foo',
         "name" => 'bar', 
         "accountId" => 'baz',
         "websiteUrl" => 'http://www.gmail.com'},
         nil)
      Analytics::Request.any_instance.stubs(:request).returns(MANAGEMENT_PROFILES)
      client.profiles.count.should == 1
      client.profiles.first.class.should == Analytics::Profile
    end
  end
end

